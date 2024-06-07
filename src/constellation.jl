# constellations are simply the array of symbols

energy_per_bit(c::Array) = 1 / log2(length(c))

# # functions to be defined
# # papr
# # dmin

function average_energy(c::Array)
     return mean(abs.(c).^2)
end

function papr(c::Array) 
    peak_energy = max(abs.(c).^2)
    average_energy 
end