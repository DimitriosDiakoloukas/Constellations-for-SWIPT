using Plots
using Distributions
using LinearAlgebra: norm
using Printf
using LaTeXStrings
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
sqam = sqam_initialization(16, dmin=0.378, spikes=4)
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

ser_sqam_sim = simulate.(Ref(sqam), snr_list, 0.0, tries, spikes=4)
ser_sqam_harvest_sim = simulate.(Ref(sqam), snr_list, harvest_energy, tries, spikes=4)
# ser_psk_sim = simulate.(Ref(psk), snr_list, 0.0, tries)
# ser_psk_harvest_sim = simulate.(Ref(psk), snr_list, harvest_energy, tries)


p = plot(yscale=:log10, minorgrid=true, ylims=(1e-6, 1.2), legend=:bottomleft, xlabel="SNR", ylabel="SER")
p = plot!(snr_list_db, ser_pam_th, label="PAM th")
# p = plot!(snr_list_db, ser_pam_harvest_th)
# p = plot!(snr_list_db, ser_pam_sim)
# p = plot!(snr_list_db, ser_pam_harvest_sim)
p = plot!(snr_list_db, ser_qam_th, label="QAM th")
# p = plot!(snr_list_db, ser_cqam_th)

# p = plot!(snr_list_db, ser_qam_harvest_th)
# p = plot!(snr_list_db, ser_qam_harvest_sim)

p = scatter!(snr_list_db, ser_pam_sim, label="PAM ε=0 sim")
p = scatter!(snr_list_db, ser_pam_harvest_sim, label="PAM ε=0.2 sim")

p = scatter!(snr_list_db, ser_qam_sim, label="QAM ε=0 sim")
p = scatter!(snr_list_db, ser_qam_harvest_sim, label="QAM ε=0.2 sim")

# p = scatter!(snr_list_db, ser_cqam_sim, label="CQAM ε=0 sim")
# p = scatter!(snr_list_db, ser_cqam_harvest_sim, label="CQAM ε=0.2 sim")

p = scatter!(snr_list_db, ser_bqam_sim, label="BQAM ε=0 sim")
p = scatter!(snr_list_db, ser_bqam_harvest_sim, label="BQAM ε=0.2 sim")
# p = scatter!(snr_list_db, ser_psk_sim, label="PSK sim")
# p = scatter!(snr_list_db, ser_psk_harvest_sim, label="PSK Harvest sim")
p = scatter!(snr_list_db, ser_sqam_sim, label="sQAM ε=0 sim")
p = scatter!(snr_list_db, ser_sqam_harvest_sim, label="sQAM ε=0.2 sim")