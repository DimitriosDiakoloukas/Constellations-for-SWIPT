# const sweep = 0:0.5:24
const sweep = 0:24
snr_list_db = [x for x ∈ sweep]
snr_list = db_inv.(snr_list_db)