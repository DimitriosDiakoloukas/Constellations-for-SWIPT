using SpecialFunctions

function Q(x)
    return 0.5 * erfc(x / sqrt(2))
end
