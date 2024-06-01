function dB(power::Float64)
    return 10*log10(power)
end

function dB_inv(dbs::Float64)
    return 10^(dbs / 10)
end