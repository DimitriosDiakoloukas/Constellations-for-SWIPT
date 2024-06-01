include("gaussian.jl")
include("dB.jl")

# define the energy of the pulse using unit average energy
E_s = 1.0
M_pam = 16 
E_g = 3/(M_pam^2 - 1)
E_b = 1/log2(M_pam)

# constellation definition
pam_16_constellation = [(2*i - M_pam - 1)*sqrt(E_g) for i ∈ 1:M_pam]

ser_pam(snr::Float64) = 2 * ((M_pam - 1)/M_pam) * Q( sqrt( 6*log2(M_pam) * snr / (M_pam^2 - 1) ) )

snr_list_db = [x for x ∈ 0:0.5:24]
snr_list = dB_inv.(snr_list_db)
N0_list = E_b ./ snr_list

ser_pam_th = ser_pam.(snr_list)
