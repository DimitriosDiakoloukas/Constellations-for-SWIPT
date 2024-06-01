using Plots
using Distributions

include("gaussian.jl")
include("decibel.jl")
include("snr.jl")
include("constellation.jl")
include("simulation.jl")
include("pam.jl")

p = plot(snr_list_db, [ser_pam_th, ser_pam_sim], yscale=:log10, minorgrid=true)
p = scatter!(snr_list_db, [ser_pam_th, ser_pam_sim])
p = plot!(snr_list_db, [ser_pam_harvest_th, ser_pam_harvest_sim])
p = scatter!(snr_list_db, [ser_pam_harvest_th, ser_pam_harvest_sim])