clear

global dir		"D:\Kerja\Susenas"
global data		"D:\Kerja\Susenas\Susenas Maret 2017"
cd				"$dir"

set more off
cap log close
log using "Cek Konversi_acuan_keep", replace


**-----------------------------------------
** 1. Prepare Nutrient Data (Tabel Konversi)
**-----------------------------------------

use	"susenas nutrient.dta", replace
duplicates 	tag code17, g(tag)
tab tag
*br if tag==1
duplicates drop code17, force
save "susenas nutrient_ed", replace

**-----------------------------------------
** 2. Merge dengan blok 41 dan hitung intake-nya
**-----------------------------------------
use 	"$data\blok41gab_19_34_diseminasi.dta", clear
keep if r101==31
gen		code17=kode
gen		qcal_saya=b41k9/7							
merge 	m:1 code17 using "susenas nutrient_ed.dta"
keep 	if _merge==3

#delimit; 

global nutlist calcium phosphor iron vit_a vit_b vit_c water e_p vit_b1 magnesium
potassium sodium zinc vit_b6 vit_b12 vit_e vit_d vit_k;

foreach var of  varlist $nutlist  {;
gen tot_`var'_2= `var' * qcal_saya;
};


#delimit cr 
collapse (first) r101-r301 f_edible_bdd f_weight serving $nutlist qcal_saya (sum) tot*, by(renum code17) 
save "temp-results", replace

**-----------------------------------------
**3. Bandingkan hasilnya dengan data acuan
**-----------------------------------------
u "convertion results 31.dta", replace 
quietly levelsof code17
di r(r) // 218

replace code17=code if code17==.
g x=code17-code
su x 
drop x

tempfile 31
save `31', replace

u "temp-results", replace
quietly levelsof code17
di r(r) // 230

isid renum code17 
drop r105

merge 1:1 renum code17 using "`31'" 
drop _

*sum dan browse, liat udah sama apa belum:
 mvencode _all, mv(0) override

des tot_*

#delimit;
br tot_zinc_2 tot_zinc tot_iron_2 tot_iron tot_calcium_2 tot_calcium tot_vit_a_2 
tot_vit_a tot_vit_c_2 tot_vit_c tot_vit_d_2 tot_vit_d 
tot_vit_e_2 tot_vit_e tot_vit_k_2 tot_vit_k;
su tot_zinc_2 tot_zinc tot_iron_2 tot_iron tot_calcium_2 tot_calcium tot_vit_a_2 
tot_vit_a tot_vit_c_2 tot_vit_c tot_vit_d_2 tot_vit_d 
tot_vit_e_2 tot_vit_e tot_vit_k_2 tot_vit_k;
#delimit cr

*keep code yang hasilnya tidak sama
keep if code==35 | code==64 | code==168 | code==183 | code==209
save "final result_merge_keep", replace
log close
translate "Cek Konversi_acuan_keep.smcl" "Cek Konversi_acuan_keep.pdf", replace
exit
