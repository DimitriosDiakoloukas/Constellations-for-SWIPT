using Distributions

dist = Normal(0, 1)

function Q(x::Float64)
    return 1 - cdf(dist, x)
end


