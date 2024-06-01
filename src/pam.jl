function pam_initialization(M = 16, harvest_ratio = 0)::Constellation
    E_s = 1 - harvest_ratio
    E_g = 3*E_s/(M^2 - 1)
    symbols = [(2*i - M - 1)*sqrt(E_g) for i ∈ 1:M]
    return Constellation(1, M, harvest_ratio, symbols)
end

function ser_pam(pam::Constellation, snr::Float64)
    E_s = 1 - pam.harvest_ratio
    return 2 * (1 - 1/pam.M) * Q( sqrt( 6 * E_s * log2(pam.M) * snr / (pam.M^2 - 1 ) ) )
end

pam = pam_initialization(16, 0)
pam_harvest = pam_initialization(16, 0.2)

ser_pam_th = ser_pam.(Ref(pam), snr_list)
ser_pam_harvest_th = ser_pam.(Ref(pam_harvest), snr_list)

ser_pam_sim = simulate.(Ref(pam), energy_per_bit(pam) ./ snr_list, tries)
ser_pam_harvest_sim = simulate.(Ref(pam_harvest), energy_per_bit(pam_harvest) ./ snr_list, tries)


