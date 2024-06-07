tries = 10^6

uniform_discrete_dist(M) = DiscreteUniform(1, M)
uniform_dicrete_dist_16 = uniform_discrete_dist(16)
symbol_indexes = rand(uniform_dicrete_dist_16, tries)

function detection(estimated_point, constellation::Array)
    norm_array = abs.(constellation .- estimated_point)
    detected_symbol_index = argmin(norm_array) 
    return constellation[detected_symbol_index]
end

function channel_noise(tx_symbol, distribution)
    if tx_symbol isa Complex
        noise_real = rand(distribution)
        noise_imag = rand(distribution)
        noise = Complex(noise_real, noise_imag)
    else 
        # noise = rand(distribution) + rand(distribution)
        noise = rand(distribution)
    end

    return tx_symbol + noise
end

function simulate(constellation::Array, snr, harvest_ratio, tries)
    error_count = 0
    N0 = energy_per_bit(constellation) / snr
    normal_dist = Normal(0, sqrt(N0/2))
    constellation = constellation * (1 - harvest_ratio)

    for curr ∈ 1:tries
        tx_index = symbol_indexes[curr]
        tx_symbol = constellation[tx_index]

        rx_symbol = channel_noise(tx_symbol, normal_dist)
        rx_symbol_detected = detection(rx_symbol, constellation)

        error_count += (rx_symbol_detected != tx_symbol)
    end

    println("done with $snr")
    return error_count/tries
end

function simulateIQ(constellation::Array, snr, harvest_ratio, tries)
    error_count = 0
    N0 = energy_per_bit(constellation) / snr
    normal_dist_real = Normal(0, sqrt(N0/2))
    normal_dist_imag = Normal(0, sqrt(N0/2))

    constellation = constellation * (1 - harvest_ratio)
    symbols_real = real.(constellation)
    symbols_imag = imag.(constellation)

    for curr ∈ 1:tries 
        tx_index = symbol_indexes[curr]
        tx_symbol = constellation[tx_index]

        tx_symbol_real = real(tx_symbol)
        tx_symbol_imag = imag(tx_symbol)
        rx_symbol_real = channel_noise(tx_symbol_real, normal_dist_real)
        rx_symbol_imag = channel_noise(tx_symbol_imag, normal_dist_imag)

        rx_symbol_real_detected = detection(rx_symbol_real, symbols_real)
        rx_symbol_imag_detected = detection(rx_symbol_imag, symbols_imag)

        error = (rx_symbol_real_detected != tx_symbol_real) ||   (rx_symbol_imag_detected != tx_symbol_imag)

        error_count += error
    end

    println("done with $snr")
    return error_count/tries
end




    

    