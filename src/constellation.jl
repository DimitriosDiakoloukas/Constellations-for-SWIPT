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

function dmin(c::Array) 
    return norm(c[1]-c[2])
end

function plot_constellation(c::Array)
    plt = scatter(real.(c), imag.(c), legend=false, aspect_ratio=1, framestyle=:origin)
end