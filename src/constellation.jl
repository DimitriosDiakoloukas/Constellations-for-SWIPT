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
    plt = scatter(real.(c), imag.(c), legend=false, aspect_ratio=1, framestyle=:origin)
    return plt
end

# function plot_circle_constellation(c::Array)
#     p = plot_constellation(c)
#     plot!()
# end

function symbol_harvest_transform(symbol, harvest::Float64)
    r = abs(symbol)

    arg = max(0, r^2 - harvest)
    r_new = sqrt(arg)

    return r_new*exp(im*angle(symbol))
end

function harvest_transform(constellation::Array, harvest::Float64)  
    return symbol_harvest_transform.(constellation, harvest)
end

function energy_normalizer(constellation::Array)
    k = average_energy(constellation)
    constellation /= sqrt(k)
    return constellation
end