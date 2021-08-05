*===============================================================================
*
* Project			: Prakarsa Multidimensional Poverty Index
* Authors			: Muhammad Fawdy Renardi Wahyu
* Stata Version 	: 14
* Date Created		: April 27, 2020
* Last Modified		: -
*					:
*===============================================================================

global pathf	"D:\Kerja\Project Prakasa"
set more off

use "$pathf/18 Susenas FM", clear
*jumlah penduduk
egen pop_ind=sum(weind)
egen pop_rt=sum(wert) // ini hasil yang bener

*jumlah miskin (setelah dicek, pakai yang wert yang bener)
egen poor_rt=sum(wert) if mpi_h==1 // ini hasil yang bener
egen poor_ind=sum(weind) if mpi_h==1

*jumlah indikator per risiko covid19
/*mk 1: sanitasi
egen mk1_sum=sum(wert) if mk_1==1
*mk 4:asupan gizi
egen mk4_sum=sum(wert) if mk_4==1
*ms 2: Bahan Bakar Memasak
egen ms2_sum=sum(wert) if ms_2==1*/
egen sum_risk=sum(wert) if mk_2==1 | mk_4==1 | ms_2==1
egen sum_hrisk=sum(wert) if mk_2==1 & mk_4==1 & ms_2==1

*Indikator untuk masyarakat miskin
/*mk 1: sanitasi
egen mk1_sump=sum(wert) if mk_1m==1
*mk 4:asupan gizi
egen mk4_sump=sum(wert) if mk_4m==1
*ms 2: Bahan Bakar Memasak
egen ms2_sump=sum(wert) if ms_2m==1 */
egen sum_riskp=sum(wert) if mk_2m==1 | mk_4m==1 | ms_2m==1
egen sum_hriskp=sum(wert) if mk_2m==1 & mk_4m==1 & ms_2m==1

sum pop_rt // populasi Indonesia
sum sum_* // summary stat setiap kelompok


*========Provinsi==========*
*populasi
bys kode_prov:egen pop_rt_p=sum(wert)
*orang miskin
bys kode_prov: egen poor_rt_p=sum(wert) if mpi_h==1
*jumlah indikator per risiko covid19
bys kode_prov:egen sum_risk_p=sum(wert) if mk_2==1 | mk_4==1 | ms_2==1
bys kode_prov:egen sum_hrisk_p=sum(wert) if mk_2==1 & mk_4==1 & ms_2==1

*Indikator untuk masyarakat miskin
bys kode_prov:egen sum_riskp_p=sum(wert) if mk_2m==1 | mk_4m==1 | ms_2m==1
bys kode_prov:egen sum_hriskp_p=sum(wert) if mk_2m==1 & mk_4m==1 & ms_2m==1

gen check=sum_hrisk_p-sum_hriskp_p
sum check, d

tab kode_prov, sum (sum_risk_p) means nofreq
tab kode_prov, sum (sum_hrisk_p) means nofreq
tab kode_prov, sum (sum_riskp_p) means nofreq

*========Kota==========*
*populasi
bys kode_prov:egen pop_rt_k=sum(wert) if status_kota==1
*orang miskin
bys kode_prov: egen poor_rt_k=sum(wert) if mpi_h==1 & status_kota==1
*jumlah indikator per risiko covid19
bys kode_prov:egen sum_risk_k=sum(wert) if (mk_2==1 | mk_4==1 | ms_2==1) & status_kota==1
bys kode_prov:egen sum_hrisk_k=sum(wert) if mk_2==1 & mk_4==1 & ms_2==1 & status_kota==1

*Indikator untuk masyarakat miskin
bys kode_prov:egen sum_riskp_k=sum(wert) if (mk_2m==1 | mk_4m==1 | ms_2m==1) & status_kota==1
bys kode_prov:egen sum_hriskp_k=sum(wert) if mk_2m==1 & mk_4m==1 & ms_2m==1 & status_kota==1

tab kode_prov, sum(sum_risk_k) means nofreq
tab kode_prov, sum(sum_hrisk_k) means nofreq
tab kode_prov, sum(sum_riskp_k) means nofreq

*========Desa==========*
*populasi
bys kode_prov:egen pop_rt_d=sum(wert) if status_kota==2
*orang miskin
bys kode_prov: egen poor_rt_d=sum(wert) if mpi_h==1 & status_kota==2
*jumlah indikator per risiko covid19
bys kode_prov:egen sum_risk_d=sum(wert) if (mk_2==1 | mk_4==1 | ms_2==1) & status_kota==2
bys kode_prov:egen sum_hrisk_d=sum(wert) if mk_2==1 & mk_4==1 & ms_2==1 & status_kota==2

*Indikator untuk masyarakat miskin
bys kode_prov:egen sum_riskp_d=sum(wert) if (mk_2m==1 | mk_4m==1 | ms_2m==1) & status_kota==2
bys kode_prov:egen sum_hriskp_d=sum(wert) if mk_2m==1 & mk_4m==1 & ms_2m==1 & status_kota==2

tab kode_prov, sum(pop_rt_d) means nofreq
tab kode_prov, sum(poor_rt_d) means nofreq
tab kode_prov, sum (sum_risk_d) means nofreq
tab kode_prov, sum (sum_hrisk_d) means nofreq
tab kode_prov, sum (sum_riskp_d) means nofreq

*========Per Dimensi Kehidupan==========*
bys kode_prov: egen sum_mk2= sum(wert) if mk_2==1
bys kode_prov: egen sum_mk4= sum(wert) if mk_4==1
bys kode_prov: egen sum_ms2= sum(wert) if ms_2==1

tab kode_prov, sum(sum_mk2) means nofreq
tab kode_prov, sum(sum_mk4) means nofreq
tab kode_prov, sum(sum_ms2) means nofreq

*Kota
bys kode_prov: egen sumk_mk2= sum(wert) if mk_2==1 & status_kota==1
bys kode_prov: egen sumk_mk4= sum(wert) if mk_4==1 & status_kota==1
bys kode_prov: egen sumk_ms2= sum(wert) if ms_2==1 & status_kota==1

tab kode_prov, sum(sumk_mk2) means nofreq
tab kode_prov, sum(sumk_mk4) means nofreq
tab kode_prov, sum(sumk_ms2) means nofreq

*Desa
bys kode_prov: egen sumd_mk2= sum(wert) if mk_2==1 & status_kota==2
bys kode_prov: egen sumd_mk4= sum(wert) if mk_4==1 & status_kota==2
bys kode_prov: egen sumd_ms2= sum(wert) if ms_2==1 & status_kota==2

tab kode_prov, sum(sumd_mk2) means nofreq
tab kode_prov, sum(sumd_mk4) means nofreq
tab kode_prov, sum(sumd_ms2) means nofreq

*========Per Dimensi Kehidupan: Miskin dan Berisiko==========*
bys kode_prov: egen sum_mk2m= sum(wert) if mk_2m==1
bys kode_prov: egen sum_mk4m= sum(wert) if mk_4m==1
bys kode_prov: egen sum_ms2m= sum(wert) if ms_2m==1

tab kode_prov, sum(sum_mk2m) means nofreq
tab kode_prov, sum(sum_mk4m) means nofreq
tab kode_prov, sum(sum_ms2m) means nofreq

*Kota
bys kode_prov: egen sumk_mk2m= sum(wert) if mk_2m==1 & status_kota==1
bys kode_prov: egen sumk_mk4m= sum(wert) if mk_4m==1 & status_kota==1
bys kode_prov: egen sumk_ms2m= sum(wert) if ms_2m==1 & status_kota==1

tab kode_prov, sum(sumk_mk2m) means nofreq
tab kode_prov, sum(sumk_mk4m) means nofreq
tab kode_prov, sum(sumk_ms2m) means nofreq

*Desa
bys kode_prov: egen sumd_mk2m= sum(wert) if mk_2m==1 & status_kota==2
bys kode_prov: egen sumd_mk4m= sum(wert) if mk_4m==1 & status_kota==2
bys kode_prov: egen sumd_ms2m= sum(wert) if ms_2m==1 & status_kota==2

tab kode_prov, sum(sumd_mk2m) means nofreq
tab kode_prov, sum(sumd_mk4m) means nofreq
tab kode_prov, sum(sumd_ms2m) means nofreq

save "$pathf/risiko covid19", replace
