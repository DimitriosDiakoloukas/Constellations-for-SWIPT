function qam_initialization(M = 16, harvest_ratio)::Constellation 
    N = sqrt(M)
    qam_real = pam_initialization(N, harvest_ratio)
    qam_imag = pam_initialization(N, harvest_ratio)
    symbols = [Complex(qam_real[i], qam_imag[j]) for j ∈ 1:N for i ∈ 1:N]
    return Constellation(2, M, harvest_ratio, symbols)
end

# function ser_qam(qam::Constellation, snr::Float)
    
