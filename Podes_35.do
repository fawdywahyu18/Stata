
clear

global dir		"D:\Kuliah\Asisten Mas Ade TNP2K\Susenas"
global data		"D:\Kuliah\Asisten Mas Ade TNP2K\Susenas\Susenas Maret 2017"
cd				"$dir"

use podes_35, clear
ssc install renvars

bys R101 R102: g n_des=_N

// 1. PELAYANAN DASAR 
	
	* 1.1 Pelayanan Pendidikan
	
		foreach x in B C D E {
		gen akses_`x' = inlist(R701`x'K5,1,2) | R701`x'K2 > 0 | R701`x'K3 > 0 // jawab mudah atau di desanya ada fasilitas
		}
		renvars akses_B-akses_E \ akses_TK akses_SD akses_SMP akses_SMA
	
	
	* 1.2 Pelayanan Kesehatan
	
		foreach x in A B C F G I J K L {
		gen akses_`x' = inlist(R704`x'K4,1,2) | R704`x'K2 > 0 // jawab mudah atau di desanya ada fasilitas
		}
		
		renvars akses_A-akses_L \ akses_RS akses_RSbersalin akses_puskesmas akses_poliklinik akses_dokter akses_bidan akses_poskesdes akses_polindes akses_apotek
		g akses_poskesdesXlindes= akses_poskesdes==1 | akses_polindes==1
		drop akses_poskesdes akses_polindes

		
//	2.  INFRASTRUKTUR
	
	* 2.1 Infrastruktur Ekonomi
	
		foreach x in A B C D E F1 F2 G H I J {
		g ada_`x' = R1206`x'K2 > 0 // Kalau mau ngeluarin ini
		g to_`x' = ada_`x' == 1 | inlist(R1206`x'K4,1,2) 
		}
		
		drop ada_* 
		g akses_tokoXwarung= 		to_A == 1 | to_E ==1 | to_F1 == 1 | to_F2 == 1
		g akses_pasar= 				to_B == 1 | to_C ==1 | to_D == 1
		g akses_restoranXwarungmkn= to_G == 1 | to_H==1
		g akses_hoteXpenginapan = 	to_I == 1 | to_J==1
		drop to_*
			
		foreach x in A B C {
		gen to_`x' = inlist(R1208`x'K4,1,2) | R1208`x'K2 > 0 // jawab mudah atau di desanya ada fasilitas
}
		g akses_bank= to_A == 1 | to_B == 1 | to_C ==1 
			drop to_*
			
	* 2.2 Infrasruktur Energi
	
		bys R101 R102 R103 R104: gen Tot_Kel = R501A1 + R501A2 + R501B
		gen elektrifikasi =  (R501A1 + R501A2) / Tot_Kel 
		gen ada_penerangan_jalan = inlist(R502A, 1,2)  
		gen lpgXgaskota= inlist(R503B,1,2,3) 

	* 2.3 Infrasruktur Air Bersih dan Sanitasi
	
		g minum_kemasanXledeng = inrange(R507A,1,4) 
		g mandi_ledengXsumur = inrange(R507B,1,4) 
		g ada_jambansendiri = R505A == 1
		
		
	* 2.4 Infrasruktur Komunikasi dan Informasi
		
		g ada_sinyalkuat =  inlist(R1005C, 1,3)
		g ada_4G = R1005D == 1
		g ada_pengiriman = R1007A==1 | R1007B==1 | R1007C==1
		

//  3. TRANSPORTASI
		*Akse menuju desa: Mudah jika jalan darat diperkeras, dapat dilalui sepanjang tahun, dan ada trayek tetap angkutan yg beroperasi tiap hari.
		gen 	jalan_aspalXdiperkeras = inlist(R1001B1,1,2)   // Jalan Darat antarDesa
		replace jalan_aspalXdiperkeras=. if inlist(R1001A,3,4) // Hanya lewat air atau udara
		gen 	jalan_spjgtahun = R1001B2 ==1
		replace jalan_spjgtahun=. if inlist(R1001A,3,4)

		g 		jalan_bagus= jalan_aspalXdiperkeras == 1 & jalan_spjgtahun ==1 // yg tdk ada akses darat berarti 0
		*replace jalan_bagus=. if inlist(R1001A,3,4)
		drop jalan_aspalXdiperkeras jalan_spjgtahun

		g 		transp_bagus = R1001C1==1 & R1001C2==1
		
		g 		akses_menujudesa= jalan_bagus==1 & transp_bagus==1
		replace akses_menujudesa=1 if inlist(R1001A,3,4) & transp_bagus==1

		
		g jarak_kecamatan = R1002AK5
		g biaya_kecamatan = R1002AK7/jarak_kecamatan
		la var biaya_kecamatan "Rp000/km"

		g waktu_kecamatan 		= R1002AJM*60+R1002AME/jarak_kecamatan 
		
		g jarak_kantorbupati = R1002BK5
		g biaya_kantorbupati = R1002BK7/jarak_kantorbupati
		la var biaya_kantorbupati "Rp000/km"
		g waktu_kantorbupati = R1002BJM*60+R1002BME/jarak_kantorbupati

		
// 4. 	PELAYANAN PUBLIK	
		
		foreach x in A B C D E F G H {
		g ya_`x' = R709`x'K2 == 1 
		}
		gen X =sum(ya_A-ya_H)
		g ada_KLB=X>0
		drop X ya_*
		
		g ada_giziburuk = R710 > 0
		g n_giziburuk = R710
		
		
		foreach x in A B C D E F G H I J K L {
		g ya_`x' = R901`x'K2 == 1 
		}
		gen X =sum(ya_A-ya_L)
		g ada_fasolahraga= X > 0
		drop X ya_*
		
		foreach x in A B C D E F G H I J K L {
		g ya_`x' = R901`x'K3 == 1 
		}
		gen X =sum(ya_A-ya_L)
		g ada_KLPolahraga= X > 0
		drop X ya_*

		

// 5. PENYELENGARAAN PEMERINTAHAN

		g kades_ijazah = inrange(R1701AK5,6,9)
		

	*___COLLAPSE TO DISTRICT
	collapse (mean) n_des-kades_ijazah , by(R101 R101N R102 R102N)
	drop Tot_Kel // kalau mau di-sum waktu collapse
	
	*___LABELLING
	la var biaya_kantorbupati "Rp000/km"
	la var biaya_kecamatan "Rp000/km"
	la var waktu_kecamatan "men/km"
	la var waktu_kantorbupati "men/km"

// ANALYSIS
	
	gen kabu = real(R101 + R102)
	gen kabuprioritas= inlist(kabu, 3527, 3526, 3513, 3529, 3523, 3528, 3521, 3524, 3507, 3509)
	tab kabuprioritas
	
	
	
	*Karakteristik Kemiskinan: Jatim vs 10 Kabupaten Prioritas
	
		table kabuprioritas, c(mean akses_TK mean akses_SD mean akses_SMP mean akses_SMA ) col row 
		table kabuprioritas, c(mean akses_RS mean akses_RSbersalin mean akses_puskesmas mean akses_poliklinik mean akses_dokter) col row
		table kabuprioritas, c(mean akses_bidan mean akses_apotek mean akses_poskesdesXlindes) col row
		table kabuprioritas, c(mean akses_tokoXwarung mean akses_pasar mean akses_restoranXwarungmkn mean akses_hoteXpenginapan mean akses_bank ) col row
		table kabuprioritas, c(mean elektrifikasi mean ada_penerangan_jalan mean lpgXgaskota mean minum_kemasanXledeng ) col row
		table kabuprioritas, c(mean mandi_ledengXsumur mean ada_sinyalkuat mean ada_4G mean ada_pengiriman ) col row
		table kabuprioritas, c(mean jalan_bagus mean transp_bagus mean akses_menujudesa mean biaya_kecamatan mean waktu_kecamatan ) col row
		table kabuprioritas, c(mean biaya_kantorbupati mean waktu_kantorbupati mean ada_KLB mean ada_giziburuk) col row
		table kabuprioritas, c(mean ada_fasolahraga mean ada_KLPolahraga mean kades_ijazah) col row


save podes_infra_35, replace
