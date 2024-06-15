using Plots
using Distributions
using LinearAlgebra: norm
using Printf
# using SpecialFunctions

include("gaussian.jl")
include("decibel.jl")
include("snr.jl")
include("constellation.jl")
include("pam.jl")
include("qam.jl")
include("psk.jl")
include("cqam.jl")
include("sqam.jl")
include("bqam.jl")
include("simulation.jl")

pam = pam_initialization(16)
qam = qam_initialization(16)
cqam = cqam_initialization(16, 4, dmin=0.6)
bqam = bqam_initialization(16, dmin=0.6)
psk = psk_initialization(16)
harvest_energy = 0.2

ser_pam_th = ser_pam.(Ref(pam), snr_list, 0.0)
# ser_pam_harvest_th = ser_pam.(Ref(pam), snr_list, harvest_energy)

ser_qam_th = ser_qam.(Ref(qam), snr_list, 0.0)
# ser_qam_harvest_th = ser_qam.(Ref(qam), snr_list, harvest_energy)

# ser_cqam_th = ser_cqam.(Ref(cqam), snr_list, 0.0)

ser_pam_sim = simulate.(Ref(pam), snr_list, 0.0, tries)
ser_pam_harvest_sim = simulate.(Ref(pam), snr_list, harvest_energy, tries)

ser_qam_sim = simulate.(Ref(qam), snr_list, 0.0, tries)
ser_qam_harvest_sim = simulate.(Ref(qam), snr_list, harvest_energy, tries)

ser_cqam_sim = simulate.(Ref(cqam), snr_list, 0.0, tries)
ser_cqam_harvest_sim = simulate.(Ref(cqam), snr_list, harvest_energy, tries)

ser_bqam_sim = simulate.(Ref(bqam), snr_list, 0.0, tries)
ser_bqam_harvest_sim = simulate.(Ref(bqam), snr_list, harvest_energy, tries)

# ser_psk_sim = simulate.(Ref(psk), snr_list, 0.0, tries)
# ser_psk_harvest_sim = simulate.(Ref(psk), snr_list, harvest_energy, tries)


p = plot(yscale=:log10, minorgrid=true, ylims=(1e-6, 1.2), legend=:bottomleft, xlabel="Eb/N0", ylabel="SER")
p = plot!(snr_list_db, ser_pam_th, label="PAM Theoretical")
# p = plot!(snr_list_db, ser_pam_harvest_th)
# p = plot!(snr_list_db, ser_pam_sim)
# p = plot!(snr_list_db, ser_pam_harvest_sim)
p = plot!(snr_list_db, ser_qam_th, label="QAM Theoretical")
# p = plot!(snr_list_db, ser_cqam_th)

# p = plot!(snr_list_db, ser_qam_harvest_th)
# p = plot!(snr_list_db, ser_qam_harvest_sim)

p = scatter!(snr_list_db, ser_pam_sim, label="PAM Simulation")
p = scatter!(snr_list_db, ser_pam_harvest_sim, label="PAM Harvest Simulation")

p = scatter!(snr_list_db, ser_qam_sim, label="QAM Simulation")
p = scatter!(snr_list_db, ser_qam_harvest_sim, label="QAM Harvest Simulation")

p = scatter!(snr_list_db, ser_cqam_sim, label="CQAM Simulation")
p = scatter!(snr_list_db, ser_cqam_harvest_sim, label="CQAM Harvest Simulation")

p = scatter!(snr_list_db, ser_bqam_sim, label="BQAM Simulation")
p = scatter!(snr_list_db, ser_bqam_harvest_sim, label="BQAM Harvest Simulation")
# p = scatter!(snr_list_db, ser_psk_sim, label="PSK Simulation")
# p = scatter!(snr_list_db, ser_psk_harvest_sim, label="PSK Harvest Simulation")