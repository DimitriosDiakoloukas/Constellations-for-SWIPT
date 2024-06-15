function bqam_initialization(M = 16; dmin = 0.1)
    n = 6
    N = M ÷ n
    last_circle_n = M%n
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

        push!(radii, r_next)
        push!(symbols, circle_next)
    end

    wtf = abs.(vcat(symbols...))
    left_energy = M - sum(wtf.^2)
    circle_last = psk_initialization(last_circle_n; Es=left_energy/last_circle_n, offset_angle=offset_angle+clockwise*π/6, first_angle=π/6)

    push!(symbols, circle_last)
    return vcat(symbols...)
end
