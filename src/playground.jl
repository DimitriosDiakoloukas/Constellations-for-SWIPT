using Plots
include("pam_16.jl")
include("simulation.jl")

ser_pam_sim = simulate.(Ref(pam_16_constellation), E_b ./ snr_list, tries)
p = plot(snr_list_db, [ser_pam_th, ser_pam_sim], yscale=:log10, minorgrid=true)
p = scatter!(snr_list_db, [ser_pam_th, ser_pam_sim])