using Distributions
include("gaussian.jl")

tries = 10^6

uniform_discrete_dist(M) = DiscreteUniform(1, M)
uniform_dicrete_dist_16 = uniform_discrete_dist(16)
symbol_indexes = rand(uniform_dicrete_dist_16, tries)

function detection(estimated_point, constellation::Array)
    norm_array = abs.(constellation .- estimated_point)
    return argmin(norm_array) 
end

function channel_noise(tx_symbol, distribution)
    return tx_symbol + rand(distribution)
end

function simulate(constellation, N0, tries)
    error_count = 0
    normal_dist = Normal(0, sqrt(N0/2))
    for curr ∈ 1:tries
        tx_index = symbol_indexes[curr]
        tx_symbol = constellation[tx_index]

        rx_symbol = channel_noise(tx_symbol, normal_dist)
        rx_index = detection(rx_symbol, constellation)

        error_count += rx_index != tx_index
    end

    println("done with $N0")
    return error_count/tries
end



    

    