tries = 10^6
uniform_discrete_dist(M) = DiscreteUniform(1, M)
uniform_dicrete_dist_16 = uniform_discrete_dist(16)
symbol_indexes = rand(uniform_dicrete_dist_16, tries)

function detection(estimated_point, constellation::Array)
    norm_array = abs.(constellation .- estimated_point)
    detected_symbol_index = argmin(norm_array) 
    return detected_symbol_index
end

function channel_noise(symbol, distribution::Distribution)
    noise_real = rand(distribution)
    noise_imag = rand(distribution)
    noise = Complex(noise_real, noise_imag)

    return symbol + noise
end

function simulate(constellation::Array, snr, harvest, tries; spikes=0)
    error_count = 0
    N0 = energy_per_bit(constellation) / snr
    normal_dist = Normal(0, sqrt(N0/2))

    constellation_harvested = harvest_transform(constellation, harvest, spikes=spikes)

    for curr ∈ 1:tries
        tx_index = symbol_indexes[curr]
        tx_symbol = constellation_harvested[tx_index]

        rx_symbol = tx_symbol
        rx_symbol = channel_noise(rx_symbol, normal_dist)
        rx_index = detection(rx_symbol, constellation_harvested)

        error_count += (rx_index != tx_index)
    end

    @printf("Done with %f\n", db(snr))
    return error_count/tries
end
