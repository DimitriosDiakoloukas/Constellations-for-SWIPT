# using Distributions
using SpecialFunctions

# dist = Normal(0, 1)

# function Q(x)
#     return 1 - cdf(dist, x)
# end

function Q(x)
    return 0.5 * erfc(x / sqrt(2))
end
