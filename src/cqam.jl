function cqam_symbol_packets(dmin, M, N)
    n = M ÷ N
        
    R1 = dmin / (2 * sin(π / n))
    R2 = sqrt(2)*R1
    radii = [R1, R2]
    for i ∈ 3:N-1
        Ri = max(sqrt(2) * radii[i - 1], radii[i - 2] + dmin)
        push!(radii, Ri)
    end
    
    Rn = sqrt(N - sum(r^2 for r in radii))
    push!(radii, Rn)
    return radii
end

function cqam_initialization2(M::Int=16,  N::Int=4; dmin=1.0)
    radii = cqam_symbol_packets(dmin, M, N)
    num_rings = length(radii)
    points_per_ring = M ÷ num_rings
    
    symbols = []
    for r in radii
        for θ in range(0, 2π, length=points_per_ring + 1)[1:end-1]
            push!(symbols, r * exp(im * θ))
        end
    end
    
    avg_energy = average_energy(symbols)
    symbols /= sqrt(avg_energy)
    
    return symbols
end

function cqam_initialization(M = 16, N = 4; dmin = 0.1)
    n = M ÷ N
    r1 = dmin / (2 * sin(π / n))
    circle1 = psk_initialization(n, Es=r1^2)

    next_symbol = circle1[2] + (circle1[1] - circle1[2])*exp(π/3*im)
    r2 = abs(next_symbol)
    offset_angle = angle(next_symbol)
    circle2 = psk_initialization(n; Es=r2^2, offset_angle)

    symbols = [circle1, circle2]
    radii = [r1, r2] 
    
    clockwise = 1
    switch = 1
    for i ∈ 3:N-1
        next_symbol = symbols[i-1][1] + switch*(symbols[i-2][1] - symbols[i-1][1])*exp(clockwise*π/3*im)

        r_next = abs(next_symbol)
        offset_angle = angle(next_symbol)
        circle_next = psk_initialization(n; Es=r_next^2, offset_angle)

        clockwise *= -1
        if i == 3
            switch = -1
            clockwise *= -1
        else
            switch = 1
        end
        
        push!(radii, r_next)
        push!(symbols, circle_next)
    end

    r_last = sqrt(N - sum(radii.^2))
    circle_last = psk_initialization(n; Es=r_last^2, offset_angle=offset_angle+clockwise*π/N)

    push!(symbols, circle_last)
    return vcat(symbols...)
end

function ser_cqam(qam::Array{Complex{Float64},1}, snr::Float64, harvest_ratio::Float64)
    M = length(qam)
    snr_inv = db_inv(snr)
    E_s = 1 - harvest_ratio
    prob_error = 2 * (1 - 1 / sqrt(M)) * Q(sqrt(3 * snr_inv * E_s / (M - 1)))
    return prob_error
end
