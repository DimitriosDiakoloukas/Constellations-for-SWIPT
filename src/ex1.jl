using Plots
using Distributions
using LinearAlgebra: norm
using LaTeXStrings

include("constellation.jl")
include("pam.jl")
include("qam.jl")
include("psk.jl")
include("bqam.jl")
include("cqam.jl")


dmin_n4_sweep = 0.001:0.001:0.6
dmin_n8_sweep = 0.001:0.001:0.45
dmin_sqam_sweep = 0.001:0.001:0.63

cqam_n4_papr = [papr(cqam_initialization2(16, 4, dmin=d)) for d ∈ dmin_n4_sweep]
cqam_n8_papr = [papr(cqam_initialization(16, 8, dmin=d)) for d ∈ dmin_n8_sweep]

bqam_n4_papr = [papr(bqam_initialization(16, dmin=d)) for d ∈ dmin_n4_sweep]
sqam_papr = [papr(sqam_initialization(16, dmin=d, spikes=4)) for d ∈ dmin_sqam_sweep]

pam = pam_initialization(16)
pam_papr = papr(pam)
pam_dmin = dmin_constellation(pam)

qam = qam_initialization(16)
qam_papr = papr(qam)
qam_dmin = dmin_constellation(qam)

psk = psk_initialization(16)
psk_papr = papr(psk)
psk_dmin = dmin_constellation(psk)


papr_dmin_plot = plot(xlims=(0, 0.75), ylims=(0, 8.5))
xlabel!(L"d_{\mathrm{min}}")
ylabel!(L"\mathrm{PAPR}")
yticks!(0:1:ceil(maximum(cqam_n8_papr)))
xticks!(0:0.1:ceil(maximum(dmin_n4_sweep)))
# plot!(dmin_n4_sweep, cqam_n4_papr, label="CQAM, M=16, N=4", gridalpha=0.2, gridlinewidth=2)
# plot!(dmin_n8_sweep, cqam_n8_papr, label="CQAM, M=16, N=8")
plot!(dmin_n4_sweep, bqam_n4_papr, label="BQAM, M=16")
plot!(dmin_sqam_sweep, sqam_papr, label="SQAM, M=16")
scatter!([psk_dmin], [psk_papr], label="PSK, M=16", color=:gray)
scatter!([pam_dmin], [pam_papr], label="PAM, M=16", color=:yellow)
scatter!([qam_dmin], [qam_papr], label="QAM, M=16")