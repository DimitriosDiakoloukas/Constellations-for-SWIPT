function Q(x::Float64)
    return 0.5 * erfc(x / sqrt(2))
end

function cqam_initialization(M = 16)::Array{Complex{Float64},1}
    radii = sqrt(2)^-1 * [1, 2]  
    num_rings = length(radii)
    points_per_ring = M ÷ num_rings

    symbols = Complex{Float64}[]
    for r in radii
        for θ in range(0, 2π, length=points_per_ring + 1)[1:end-1]
            push!(symbols, r * exp(im * θ))
        end
    end
    return symbols
end

function ser_cqam(qam::Array{Complex{Float64},1}, snr::Float64, harvest_ratio::Float64)
    M = length(qam)
    E_s = 1 - harvest_ratio
    d_min = minimum([abs(qam[i] - qam[j]) for i in 1:M, j in 1:M if i != j])
    prob_correct = (1 - 2 * Q(sqrt(2 * snr * E_s) / d_min))^2
    return 1 - prob_correct
end
