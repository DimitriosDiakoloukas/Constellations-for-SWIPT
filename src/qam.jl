function qam_initialization(M = 16)::Array
    N = Int32(sqrt(M))
    qam_real = pam_initialization(N)
    qam_imag = pam_initialization(N)
    symbols = sqrt(2)^-1 * [Complex(qam_real[i], qam_imag[j]) for j ∈ 1:N for i ∈ 1:N]
    return symbols
end

function ser_qam(qam::Array, snr::Float64, harvest_ratio::Float64)
    M = length(qam)
    N = Int32(sqrt(M))
    # qam_real_part = real.(qam[1:N])
    # qam_imag_part = Imag.(qam.symbols[N:N:N^2])
    sub_pam = pam_initialization(N)

    prob_correct = (1 - ser_pam(sub_pam, snr, harvest_ratio))^2
    return 1 - prob_correct
end

