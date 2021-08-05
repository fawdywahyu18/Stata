clear 
	set more off
	
	** SET UP PATH 
	// Change Dropbox path here
	global pathf "D:\Kerja\Asisten Akademik\PLN Project\data\Data stata"

	** UPLOAD DATA
	use "$pathf/dta/merge_all_final", clear
	
	** KEEP RELEVANT VARIABLES
	keep wilayah subwilayah unit_pltd nama_mesin merk rpm ///
	kwh_netto vol_bpp_fix harga_hsd kode_mesin nama_mesin

	order wilayah subwilayah unit_pltd nama_mesin merk rpm ///
	kwh_netto vol_bpp_fix harga_hsd kode_mesin nama_mesin
	
	** RANDOM SEQUENCE
	gen random = runiform()
	sort random
	
	** RANKING
	egen ranking = rank(random)
	
	** PERCENTILES
	xtile share_convertion = ranking, n(100)

	** Clean RPM dan Vol_BPP <0
	drop if vol_bpp_fix <0
	drop if rpm<1000
	
	** GENERATE NILAI KESETARAAN KALOR kKal per liter
	g kKalor_hsd = 9136.72
	g kKalor_cpo = 8530.90
	g kKalor_b20 = 8980.05
	g kKalor_b30 = 8900.64
	g kKalor_b40 = 8820.52
	g kKalor_b50 = 8739.67
	g kKalor_b60 = 8568.11
	g kKalor_b70 = 8575.83
	g kKalor_b80 = 8492.83
	g kKalor_b90 = 8409.11
	g kKalor_b100 =8324.68
	
	** GENERATE HARGA CPO 2018
	gen harga_cpo = 7664 //harga ini menggunakan harga domestik Bappebti rata2
						// selama 2018, dikonversikan terhadpa kurs rata2
						// tahun yg sama
	
	** Clean RPM KwH Netto dan Vol_BPP <0
	drop if kwh_netto < 0
	drop if vol_bpp_fix < 0
	drop if rpm < 1000
	** GENERATE BPP HSD
	replace harga_hsd = 8589
	gen bpp_hsd = harga_hsd * vol_bpp_fix
	
	** GENERATE ENERGI HSD
	g energi = kKalor_hsd*vol_bpp_fix
	
	** GENERATE ESTIMASI VOLUME B20-B100 dan CPO
	foreach i of numlist 2/10 {
		g vol_b`i'0=energi/kKalor_b`i'0
	}
	foreach i of numlist 2/10 {
		g bpp_b`i'0=harga_hsd*vol_b`i'0
	}
	g vol_cpo = energi / kKalor_cpo
	g bpp_cpo = harga_cpo * vol_cpo

	
	** GENERATE BPP PER KWH
	local bbm hsd cpo b10 b20 b30 b40 b50 b60 b70 b80 b90 b100
	foreach var of local bbm {
		g bpp_kwh_`var'=bpp_`var'/kwh_netto
	}
	*summary stat bpp all
	local bpp bpp_kwh_hsd bpp_kwh_cpo ///
	bpp_kwh_b20 bpp_kwh_b30 bpp_kwh_b40 bpp_kwh_b50 bpp_kwh_b60 ///
	bpp_kwh_b70 bpp_kwh_b80 bpp_kwh_b90 bpp_kwh_b100
	
	sum `bpp', d
	
	foreach var of local bpp {
			sum `var', d
			drop if `var' < `r(p1)' | `var' > `r(p99)'
	}
	sum `bpp', d
	**Generate variable volume penghematan
	bys share_convertion: egen vol_hemat= total(vol_bpp_fix)
	collapse (mean) vol_hemat, by(share_convertion)
	local f=0
	foreach i of numlist 1/100 {
	
		gen hemat_vol_`i'=vol_hemat if share_convertion <= `i'
	}
	*end
	collapse (sum) hemat_vol_*
	gen id=_n
	reshape long hemat_vol_, i(id) j(share_convertion)
	
	**plotting data
	#delimit;
	graph twoway
	(line hemat_vol_ share_convertion),
	scheme(plotplain)
	legend(label(1 hemat_vol_) label(2 Persentase Konversi))
	title("Volume Penghematan HSD") xtitle("Persentase Konversi") 
	ytitle("Volume HSD") name(grafik_penghematan, replace);
	#delimit cr
	
	
	graph export "$pathf/figure/konversi_penghematan_clean.png", as(png) replace
	save "$pathf/dta/final-results_penghematan_clean.dta", replace

	
	
	
	
	
