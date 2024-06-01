tries = 10^6

uniform_discrete_dist(M) = DiscreteUniform(1, M)
uniform_dicrete_dist_16 = uniform_discrete_dist(16)
symbol_indexes = rand(uniform_dicrete_dist_16, tries)

function detection(estimated_point, constellation::Constellation)
    norm_array = abs.(constellation.symbols .- estimated_point)
    return argmin(norm_array) 
end

function channel_noise(tx_symbol, distribution)
    if tx_symbol isa Complex
        noise_real = rand(distribution)
        noise_imag = rand(distribution)
        noise = Complex(noise_real, noise_imag)
    else 
        noise = rand(distribution) + rand(distribution)
    end

    return tx_symbol + noise
end

function simulate(constellation::Constellation, N0, tries)
    error_count = 0
    normal_dist = Normal(0, sqrt(N0/4))
    for curr ∈ 1:tries
        tx_index = symbol_indexes[curr]
        tx_symbol = constellation.symbols[tx_index]

        rx_symbol = channel_noise(tx_symbol, normal_dist)
        rx_index = detection(rx_symbol, constellation)

        error_count += (rx_index != tx_index)
    end

    println("done with $N0")
    return error_count/tries
end



    

    