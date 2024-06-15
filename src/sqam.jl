function sqam_initialization(M=16; dmin=0.1, spikes=1)
    N = Int32(sqrt(M))
    sqam = qam_initialization(M)
    homothecy = dmin/dmin_constellation(sqam)

    sqam *= homothecy

    spike_bonus_energy = (1 - average_energy(sqam)*M)/spikes
    spike_ratio = sqrt(1 + spike_bonus_energy)


    if spikes > 0 
        sqam[1] *= spike_ratio
    end
    if spikes > 1
        sqam[M] *= spike_ratio
    end
    if spikes > 2
        sqam[N] *= spike_ratio
    end
    if spikes > 3
        sqam[M - N + 1] *= spike_ratio
    end

    # sqam = energy_normalizer(sqam)
    return sqam
end