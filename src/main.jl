using Plots
using Distributions
using LinearAlgebra: norm
# using SpecialFunctions

include("gaussian.jl")
include("decibel.jl")
include("snr.jl")
include("constellation.jl")
include("simulation.jl")
include("pam.jl")
include("qam.jl")
include("cqam.jl")

pam = pam_initialization(16)
qam = qam_initialization(16)
cqam = cqam_initialization(16)
harvest_ratio = 0.2

ser_pam_th = ser_pam.(Ref(pam), snr_list, 0.0)
ser_pam_harvest_th = ser_pam.(Ref(pam), snr_list, harvest_ratio)

ser_qam_th = ser_qam.(Ref(qam), snr_list, 0.0)
ser_qam_harvest_th = ser_qam.(Ref(qam), snr_list, harvest_ratio)

ser_cqam_th = ser_cqam.(Ref(cqam), snr_list, 0.0)

# ser_pam_sim = simulate.(Ref(pam), snr_list, 0.0, tries)
# ser_pam_harvest_sim = simulate.(Ref(pam), snr_list, harvest_ratio, tries)

# ser_qam_sim = simulateIQ.(Ref(qam), snr_list, 0.0, tries)
# ser_qam_harvest_sim = simulateIQ.(Ref(qam), snr_list, harvest_ratio, tries)

p = plot(yscale=:log10, minorgrid=true, ylims=(1e-6, 1.2), legend=:false)
p = plot!(snr_list_db, ser_pam_th)
# p = plot!(snr_list_db, ser_pam_harvest_th)
# p = plot!(snr_list_db, ser_pam_sim)
# p = plot!(snr_list_db, ser_pam_harvest_sim)
p = plot!(snr_list_db, ser_qam_th)
p = plot!(snr_list_db, ser_cqam_th)

# p = plot!(snr_list_db, ser_qam_harvest_th)
# p = plot!(snr_list_db, ser_qam_sim)
# p = plot!(snr_list_db, ser_qam_harvest_sim)

# p = scatter!(snr_list_db, ser_pam_sim)
# p = scatter!(snr_list_db, ser_qam_sim)
# p = scatter!(snr_list_db, ser_pam_harvest_sim)
# p = scatter!(snr_list_db, ser_qam_harvest_sim)