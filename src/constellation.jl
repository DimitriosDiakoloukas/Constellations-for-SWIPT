struct Constellation 
    dim::Int32
    M::Int32
    harvest_ratio::Float64
    symbols::Array
end

energy_per_bit(c::Constellation) = 1 / log2(c.M)

# functions to be defined
# papr
# dmin