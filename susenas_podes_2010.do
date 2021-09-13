
** Susenas: 2010, Podes: 2011**
** by Fawdy


clear
set more off
global pathf	"D:\Pelatihan Stata"
cd				"$pathf"

cap log close
log using "jawaban_bener.smcl", replace
*Loading data
u "data\susenas_jul10.dta", clear

*Rename variable
rename b1r1 kode_prov
rename b1r2 kode_kab
rename b1r3 kode_kec
rename b1r4 kode_desa
rename pcexp peng_capita
rename povline garis_kemiskinan

*creating new id desa
tostring kode_prov kode_kab kode_kec kode_desa, gen(prov kab kec desa)
replace kab= "0" + kab if length(kab)==1
replace kec= "00" + kec if length(kec)==1
replace kec= "0" + kec if length(kec)==2
replace desa= "00" + kec if length(desa)==1
replace desa= "0" + kec if length(desa)==2

gen desa_id=prov+kab+kec+desa
gen kab_id=prov+kab

*household size and household exp
gen hh_size=weind/wert
gen hh_exp=peng_capita*hh_size

*Sum by provinces (finding population)
bys kode_prov: egen pop = sum(wert)
bys kode_prov: egen pop_ind = sum(weind)

* Real expenditure
bys kode_prov: egen wa_povline = sum((garis_kemiskinan*weind)/pop_ind)
bys kode_prov: gen pengali = wa_povline/garis_kemiskinan
bys kode_prov: gen rpeng_capita = peng_capita*pengali

*Persentil
bys kode_prov: egen p20=pctile(rpeng_capita), p(20)
bys kode_prov: egen p80=pctile(rpeng_capita), p(80)

*Poor and non-poor
bys kode_prov: gen poor=1 if rpeng_capita<p20
bys kode_prov: replace poor=0 if rpeng_capita>p80

duplicates report kode_prov kode_kab kode_kec kode_desa

save "data\susenas_jul10_mod.dta", replace

*Podes
u "data\podes_2011.dta", clear
keep if kode_prov==71 | kode_prov==72 | kode_prov==73
merge 1:m kode_prov kode_kab kode_kec kode_desa using "data\susenas_jul10_mod.dta"
keep if _merge==3

* Generating the conditions from podes_2011
encode r1001b1, g(akses_jalan)
gen akses_pasar=1 if r1205a==1 | r1205b<3
replace akses_pasar=0 if r1205a==2 & r1205b>=3

* Generating number of people for each provinces
bys kode_prov: sum pop_ind

* Generating number of poor and nonpoor people for each provinces
bys kode_prov: egen poor_ind = sum(weind) if poor==1
bys kode_prov: egen npoor_ind = sum(weind) if poor==0

* Generating share of poor people with certain access
bys kode_prov: egen poor_ind_jalan = sum(weind) if poor==1 & akses_jalan==1
gen poor_share_jalan = poor_ind_jalan/poor_ind
bys kode_prov: sum poor_share_jalan

bys kode_prov: egen poor_ind_pasar = sum(weind) if poor==1 & akses_pasar==1
gen poor_share_pasar = poor_ind_pasar/poor_ind
bys kode_prov: sum poor_share_pasar

log close
translate "jawaban_bener.smcl" "jawaban_bener.pdf", replace
exit


