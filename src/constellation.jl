# struct Constellation 
#     M::Int32
#     harvest_ratio::Float64
#     symbols::Array
# end

energy_per_bit(c::Array) = 1 / log2(length(c))

# # functions to be defined
# # papr
# # dmin

# constellations are simply the array of symbols