using Plots
using Distributions
using LinearAlgebra: norm
using Printf

include("gaussian.jl")
include("decibel.jl")
include("snr.jl")
include("constellation.jl")
include("pam.jl")
include("qam.jl")
include("psk.jl")
include("cqam.jl")
include("bqam.jl")
include("simulation.jl")

harvest_sweep = 0:0.025:4
cqam_max_papr = cqam_initialization(16, 4, dmin=0.001)
cqam_max_dmin = cqam_initialization(16, 4, dmin=0.6)
pam = pam_initialization(16)
qam = qam_initialization(16)
bqam_max_papr = bqam_initialization(16, dmin=0.001)
bqam_max_dmin = bqam_initialization(16, dmin=0.6)

num_tries = 1000
dbs = 20

ser_over_e_pam = simulate.(Ref(pam), db_inv(dbs), harvest_sweep, num_tries)
ser_over_e_cqam_papr = simulate.(Ref(cqam_max_papr), db_inv(dbs), harvest_sweep, num_tries)
ser_over_e_cqam_dmin = simulate.(Ref(cqam_max_dmin), db_inv(dbs), harvest_sweep, num_tries)
ser_over_e_qam = simulate.(Ref(qam), db_inv(dbs), harvest_sweep, num_tries)
ser_over_e_bqam_papr = simulate.(Ref(bqam_max_papr), db_inv(dbs), harvest_sweep, num_tries)
ser_over_e_bqam_dmin = simulate.(Ref(bqam_max_dmin), db_inv(dbs), harvest_sweep, num_tries)


p = plot(legend=:bottomright, xlabel="Normalized Harvested Energy ϵ(x)", ylabel="SER")
p = plot!(harvest_sweep, ser_over_e_pam, label="PAM")
p = plot!(harvest_sweep, ser_over_e_cqam_papr, label="CQAM, N=4, Max PAPR")
p = plot!(harvest_sweep, ser_over_e_cqam_dmin, label="CQAM, N=4, Max dmin")
p = plot!(harvest_sweep, ser_over_e_qam, label="QAM")
p = plot!(harvest_sweep, ser_over_e_bqam_papr, label="BQAM, N=4, Max PAPR")
p = plot!(harvest_sweep, ser_over_e_bqam_dmin, label="BQAM, N=4, Max dmin")
