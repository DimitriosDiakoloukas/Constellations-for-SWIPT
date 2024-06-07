function pam_initialization(M = 16)::Array
    E_g = 3*1/(M^2 - 1)
    symbols = [(2*i - M - 1)*sqrt(E_g) for i ∈ 1:M]
    return symbols
end

function ser_pam(pam::Array, snr::Float64, harvest_ratio::Float64)
    M = length(pam)
    E_s = 1 - harvest_ratio
    return 2 * (1 - 1/M) * Q( sqrt( 6 * E_s * log2(M) * snr / (M^2 - 1) ) )
end

