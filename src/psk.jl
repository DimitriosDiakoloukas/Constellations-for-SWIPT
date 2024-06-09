function psk_initialization(M = 16; Es = 1, offset_angle=0)
    r = sqrt(Es)
    ϕ = offset_angle
    symbols = [r*exp((θ + ϕ)*im) for θ ∈ range(0, 2π, M + 1)]
    return symbols[1:end-1]
end