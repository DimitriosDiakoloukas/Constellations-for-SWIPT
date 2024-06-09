function psk_initialization(M = 16)
    r = 1
    symbols = [r*exp(θ*im) for θ ∈ range(0, 2π, M + 1)]
    return symbols[1:end-1]
end