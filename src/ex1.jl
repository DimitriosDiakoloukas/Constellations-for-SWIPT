using Plots

include("constellation.jl")
include("pam.jl")
include("qam.jl")
include("cqam.jl")

dmin_N4_sweep = 0.001:0.001:0.6
dmin_N8_sweep = 0.001:0.001:0.45

cqam_N4_papr = [papr(cqam_initialization(16, 4, dmin=d)) for d ∈ dmin_N4_sweep]
cqam_N8_papr = [papr(cqam_initialization(16, 8, dmin=d)) for d ∈ dmin_N8_sweep]

pam = pam_initialization(16)
pam_papr = papr(pam)
pam_dmin = dmin(pam)

qam = qam_initialization(16)
qam_papr = papr(qam)
qam_dmin = dmin(qam)

psk = psk_initialization(16)
psk_papr = papr(psk)
psk_dmin = dmin(psk)


papr_dmin_plot = plot(xlims=(0, 0.75), ylims=(0, 8.5))
yticks!(0:1:ceil(maximum(cqam_N8_papr)))
xticks!(0:0.1:ceil(maximum(dmin_N4_sweep)))
plot!(dmin_N4_sweep, cqam_N4_papr, label="CQAM, M=16, N=4", gridalpha=0.2, gridlinewidth=2)
plot!(dmin_N8_sweep, cqam_N8_papr, label="CQAM, M=16, N=8")
scatter!([psk_dmin], [psk_papr], label="PSK, M=16", color=:gray)
scatter!([pam_dmin], [pam_papr], label="PAM, M=16", color=:yellow)
scatter!([qam_dmin], [qam_papr], label="QAM, M=16")