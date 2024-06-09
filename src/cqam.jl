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

function cqam_initialization(M::Int=16, dmin::Float64=1.0, N::Int=4)::Array{Complex{Float64},1}
    radii = cqam_symbol_packets(dmin, M, N)
    num_rings = length(radii)
    points_per_ring = M ÷ num_rings
    
    symbols = Complex{Float64}[]
    for r in radii
        for θ in range(0, 2π, length=points_per_ring + 1)[1:end-1]
            push!(symbols, r * exp(im * θ))
        end
    end
    
    avg_energy = average_energy(symbols)
    symbols /= sqrt(avg_energy)
    
    return symbols
end

function ser_cqam(qam::Array{Complex{Float64},1}, snr::Float64, harvest_ratio::Float64)
    M = length(qam)
    snr_inv = db_inv(snr)
    E_s = 1 - harvest_ratio
    prob_error = 2 * (1 - 1 / sqrt(M)) * Q(sqrt(3 * snr_inv * E_s / (M - 1)))
    return prob_error
end
