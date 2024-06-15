function psk_initialization(M = 16; Es = 1, offset_angle=0, first_angle=0)
    r = sqrt(Es)
    ϕ = offset_angle
    symbols = [r*exp((θ + ϕ)*im) for θ ∈ range(0, 2π, M + 1)]
    
    # bqam formation hack
    if (first_angle != 0 && M ==4) 
        symbols[2] *= cis(first_angle - offset_angle)
        symbols[4] = -symbols[2]
    end
    return symbols[1:end-1]
end