# constellations are simply the array of symbols
# convention: the first two symbols of the constellation array should always have a distance of dmin

energy_per_bit(c::Array) = 1 / log2(length(c))

function average_energy(c::Array)
     return mean(abs.(c).^2)
end

function papr(c::Array) 
    peak_energy = maximum(abs.(c).^2)
    avg_energy = average_energy(c)
    return peak_energy / avg_energy
end

function dmin_constellation(c::Array) 
    return norm(c[1]-c[2])
end

function dmin_calculate(c::Array) 
    dmin = Inf
    for symbol ∈ c 
        for other_symbol ∈ c 
            if symbol == other_symbol
                continue
            end
            dmin = min(norm(symbol - other_symbol), dmin)
        end
    end

    return dmin
end

function plot_constellation(c::Array)
    plt = scatter(real.(c), imag.(c), legend=false, aspect_ratio=1, framestyle=:origin, label="ε = 0")
    return plt
end

function symbol_harvest_transform(symbol, harvest::Float64)
    r = abs(symbol)

    arg = max(0, r^2 - harvest)
    r_new = sqrt(arg)

    return r_new*exp(im*angle(symbol))
end

function harvest_transform(constellation::Array, harvest::Float64; spikes=0)  
    if spikes == 0
        return symbol_harvest_transform.(constellation, harvest)
    end


    result_const = deepcopy(constellation)
    # we need to normalize the harvest so we remove harvest*M/spikes from each spike
    M = length(result_const)
    N = Int32(sqrt(M))
    normalized_harvest = harvest * M / spikes 

    if spikes > 0 
        result_const[1] = symbol_harvest_transform(result_const[1], normalized_harvest)
    end
    if spikes > 1
        result_const[M] = symbol_harvest_transform(result_const[M], normalized_harvest)
    end
    if spikes > 2
        result_const[N] = symbol_harvest_transform(result_const[N], normalized_harvest)
    end
    if spikes > 3
        result_const[M-N+1] = symbol_harvest_transform(result_const[M-N+1], normalized_harvest)
    end 

    if result_const[1] == 0
        greedy_energy = harvest*M - papr(constellation)*spikes
        new_res = []
        for x ∈ result_const
            if x == 0
                continue
            end
            push!(new_res, x)
        end

        new_res = harvest_transform(new_res, greedy_energy, spikes=0)
        result_const = vcat(new_res, zeros(spikes))
    end

    return result_const
end

function energy_normalizer(constellation::Array)
    k = average_energy(constellation)
    constellation /= sqrt(k)
    return constellation
end