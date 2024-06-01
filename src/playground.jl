p = plot(snr_list_db, [ser_pam_th, ser_pam_sim], yscale=:log10, minorgrid=true)
p = scatter!(snr_list_db, [ser_pam_th, ser_pam_sim])