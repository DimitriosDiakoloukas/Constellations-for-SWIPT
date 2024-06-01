function db(power)
    return 10*log10(power)
end

function db_inv(dbs)
    return 10^(dbs / 10)
end