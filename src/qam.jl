function qam_initialization(M = 16, harvest_ratio = 0)::Constellation 
    N = Int32(sqrt(M))
    qam_real = pam_initialization(N, harvest_ratio)
    qam_imag = pam_initialization(N, harvest_ratio)
    symbols = [Complex(qam_real.symbols[i], qam_imag.symbols[j]) for j ∈ 1:N for i ∈ 1:N]
    return Constellation(M, harvest_ratio, symbols)
end

function ser_qam(qam::Constellation, snr::Float64)
    N = Int32(sqrt(qam.M))
    qam_real_part = real.(qam.symbols[1:N])
    # qam_imag_part = Imag.(qam.symbols[N:N:N^2])
    sub_pam = pam_initialization(N, qam.harvest_ratio)

    prob_correct = (1 - ser_pam(sub_pam, snr))^2
    return 1 - prob_correct
end

qam = qam_initialization(16, 0.0)

ser_qam_th = ser_qam.(Ref(qam), snr_list)

ser_qam_sim = simulate.(Ref(qam), energy_per_bit(qam) ./ snr_list, tries)     
    
