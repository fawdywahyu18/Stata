* ==============================================================================
*
* Project			: Lomba paper LPS
* File				: Merge Data from IFLS
* Authors   		: Muhammad Fawdy Renardi Wahyu
* Stata version  	: 16
* Date created		: March 3, 2020
* Last modified  	: August 1, 2020
* Last modified by	: Fawdy
* ==============================================================================

global pathf		"D:\Kerja\Project IFLS"
global ifls5f		"D:\Kerja\Project IFLS\IFLS 5\Data Household Survey"
global ifls5c		"D:\Kerja\Project IFLS\IFLS 5\Data Community Survey"
global ifls4c		"D:\Kerja\Project IFLS\IFLS 4\Community Data"
global ifls4f		"D:\Kerja\Project IFLS\IFLS 4\Household Data"

*Merge 2014
use "$pathf/Data/HHCharacteristics2014.dta", clear
merge 1:1 hhid14 pid14 using "$pathf/Data/SmokingBehavior2014.dta"
	keep if _merge==3
	drop _merge
merge 1:1 hhid14 pid14 using "$pathf/Data/HealthCondition2014.dta"
	keep if _merge==3
	drop _merge
merge 1:1 hhid14 pid14 using "$pathf/Data/Literacy2014.dta"
	keep if _merge==3
	drop _merge
merge 1:1 hhid14 pid14 using "$pathf/Data/RiskTime2014.dta"
	keep if _merge==3
	drop _merge
merge 1:m hhid14 pid14 using "$pathf/Data/PersonTrack2014.dta"
	keep if _merge==3
	drop _merge
merge m:1 hhid14 using "$pathf/Data/LivingArea2014.dta"
	keep if _merge==3
	drop _merge
merge m:1 commid using "$pathf/Data/CommunityBank2014.dta"
	drop if _merge==2
	drop _merge
merge m:1 hhid14 using "$pathf/Data/HouseCharacteristics2014.dta"
	keep if _merge==3
	drop _merge
merge m:1 hhid14 using "$pathf/Data/HouseholdAsset2014.dta"
	keep if _merge==3
	drop _merge
#delimit;
drop km02a km05b km06x km06a km06bx km07 km08x km08a km08f km08bx km08c
km08dx km08e km09x km10x km11 km14 km15 version module;
#delimit cr
/* foreach x of varlist _all {
	rename `x' `x'_14
}
rename pidlink_14 pidlink
rename hhid14_9_14 hhid14_9
rename hhid14_14 hhid14 */
rename hhid14 hhid
rename pid14 pid
rename commid14 commid
rename pwt14xa pwtxa
gen year=2014
save "$pathf/Data/Merge2014.dta", replace

*Merge 2007
use "$pathf/Data/HHCharacteristics2007.dta", clear
merge 1:1 hhid07 pid07 using "$pathf/Data/SmokingBehavior2007.dta"
	keep if _merge==3
	drop _merge
merge 1:1 hhid07 pid07 using "$pathf/Data/HealthCondition2007.dta"
	keep if _merge==3
	drop _merge
merge 1:1 hhid07 pid07 using "$pathf/Data/Literacy2007.dta"
	keep if _merge==3
	drop _merge
merge 1:1 hhid07 pid07 using "$pathf/Data/RiskTime2007.dta"
	keep if _merge==3
	drop _merge
merge 1:m hhid07 pid07 using "$pathf/Data/PersonTrack2007.dta"
	keep if _merge==3
	drop _merge
merge m:1 hhid07 using "$pathf/Data/LivingArea2007.dta"
	keep if _merge==3
	drop _merge
merge m:1 commid using "$pathf/Data/CommunityBank2007.dta"
	drop if _merge==2
	drop _merge
merge m:1 hhid07 using "$pathf/Data/HouseCharacteristics2007.dta"
	keep if _merge==3
	drop _merge
merge m:1 hhid07 using "$pathf/Data/HouseholdAsset2007.dta"
	keep if _merge==3
	drop _merge
#delimit;
drop km02a km06x km06bx km08x km08bx km08c km08dx km08e 
km09x km10x km11 version module;
#delimit cr
/* foreach x of varlist _all {
	rename `x' `x'_07
}
rename pidlink_07 pidlink
rename hhid07_07 hhid07 */
rename hhid07 hhid
rename pid07 pid
rename commid07 commid
rename pwt07xa pwtxa
gen year=2007
save "$pathf/Data/Merge2007.dta", replace

*Merge all
use "$pathf/Data/Merge2014.dta", clear
encode HouseSize, g(HouseSizen)
drop HouseSize
rename HouseSizen HouseSize
append using "$pathf/Data/Merge2007.dta"
bys hhid pid: gen nyear=_N			//use balance panel
keep if nyear==2
drop nyear
save "$pathf/Data/Merge_all.dta", replace

* RISK ASSESSMENT
use "$pathf/Data/Merge_all.dta", clear
gen d_year=year==2014

generate RiskMoney=.
	replace RiskMoney=1 if RiskChoose1==1 & RiskChoose2==1
	replace RiskMoney=1 if RiskChoose1==1 & RiskChoose2==8
	replace RiskMoney=2 if RiskChoose1==2
	replace RiskMoney=2 if RiskChoose2==2
	replace RiskMoney=3 if RiskChoose4==2
	replace RiskMoney=4 if RiskChoose3==2
	replace RiskMoney=5 if RiskChoose5==2
	
generate RiskIncome=.
	replace RiskIncome=1 if RiskChoose11==1 & RiskChoose2==1
	replace RiskIncome=1 if RiskChoose11==1 & RiskChoose2==8
	replace RiskIncome=2 if RiskChoose11==2
	replace RiskIncome=2 if RiskChoose12==2
	replace RiskIncome=3 if RiskChoose14==2
	replace RiskIncome=4 if RiskChoose13==2
	replace RiskIncome=5 if RiskChoose15==2
	
generate TimePreference=.
	
drop if RiskMoney==. | RiskIncome==.

bys hhid pid: gen nyear=_N			//use balance panel
keep if nyear==2
save "$pathf/Data/Merge_all.dta", replace

*Analisis
set more off
use "$pathf/Data/Merge_all.dta", clear
gen risk_money=0 if RiskMoney==1 | RiskMoney==2
replace risk_money=1 if RiskMoney==3 | RiskMoney==4 | RiskMoney==5
replace HouseType=. if HouseType==95 | HouseType==99
gen log_earning=log(TotalEarning)
gen log_asset=log(TotalAsset)
save "$pathf/Data/Merge_all.dta", replace

*Kernell Regression
global HHchar HHAge HHYearsOfEducation NumberMember 
global health TobaccoHabitDummy HealthCondition 
global lit LiteracyNewspaperIna
global house HouseType HouseFloor HouseWalls HouseRoof HouseSanitary*

*Risk Money Analysis
	*Kernel Estimation for standard model
	/*describe *_*, fullnames
	
	*Fisrt Difference
	local delta log_earning log_asset NumberMember HHAge
	foreach var of local delta {
		bys hhid pid: gen `var'd1=`var'-`var'[_n-1]
	}
	npregress kernel RiskMoney log_earning log_asset HHAge HHYearsOfEducation NumberMember i.Urban i.d_year, predict(hatvar1*) reps(10) seed(010101) nolog
	
	des hatvar*
	
	*Estimating the difference between year
	margins d_year, vce(bootstrap)
	margins r.d_year
	
	*Estimating the difference between rural and urban
	margins Urban
	margins r.Urban */
	
	use "$pathf/Data/Analisis.dta", clear
	
	merge 1:1 hhid pid year using "$pathf/Data/Merge_all.dta"
	keep if _merge==3
	drop _merge
	
	global graf "D:\Kerja\Project IFLS\Graph"
	cd "$graf"
	
	*Plot the deriv for age
	lowess hatvar14  HHAge
	graph export RiskMoneyAge.png, replace
	
	*Plot the deriv to TotalEarning
	lowess hatvar12 log_earning, gen(deriv12) nograph
	twoway scatter deriv12 log_earning
	graph export RiskMoneyEarning.png, replace
	
	*Plot the deriv to TotalAsset
	lowess hatvar13 log_asset, gen(deriv13) nograph
	twoway scatter deriv13 log_asset
	, yscale(range(0(.001).1))
	graph export RiskMoneyAsset.png, replace
	
	*Plot the deriv to Years of Education
	lowess hatvar15 HHYearsOfEducation
	graph export RiskMoneyEduc.png, replace
	
	*Table for province
	tab PrvID [aw=pwtxa], sum(hatvar11) means nofreq
	tab PrvID [aw=pwtxa], sum(RiskMoney) means nofreq
	tab PrvID [aw=pwtxa]
	
	*Summary of first derivative
	sum hatvar12, d
	
	*Mean Square Error
	gen errorsq= (RiskMoney-hatvar11)^2
	sum errorsq
	
	*Region ID
	gen RegID=1 if PrvID>=11 & PrvID<=21
	replace RegID=3 if PrvID>=31 & PrvID<40
	replace RegID=5 if PrvID>=51 & PrvID<60
	replace RegID=6 if PrvID>=61 & PrvID<70
	replace RegID=7 if PrvID>=71 & PrvID<80
	
	tab RegID [aw=pwtxa], sum(hatvar11) means nofreq
	tab RegID [aw=pwtxa], sum(RiskMoney) means nofreq
	tab RegID [aw=pwtxa], sum(errorsq) means nofreq
	save "$pathf/Data/Analisis.dta", replace

*Risk Income Analysis
	*Kernel Estimation for standard model
	/* describe *_*, fullnames
	
	npregress kernel RiskIncome log_earning log_asset HHAge HHYearsOfEducation NumberMember i.Urban i.d_year, predict(hatvar2*) reps(10) seed(010101) nolog
	des hatvar2*
	
	*Estimating the difference between year
	margins d_year
	margins r.d_year
	
	*Estimating the difference between rural and urban
	margins Urban
	margins r.Urban */
	
	use "$pathf/Data/AnalisisRiskIncome.dta", clear
	
	merge 1:1 hhid pid year using "$pathf/Data/Merge_all.dta"
	keep if _merge==3
	drop _merge
	
	global graf "D:\Kerja\Project IFLS\Graph"
	cd "$graf"
	
	*Plot the deriv for age
	lowess hatvar24  HHAge
	graph export RiskIncomeAge.png, replace
	
	*Plot the deriv to TotalEarning
	lowess hatvar22 log_earning
	graph export RiskIncomeEarning.png, replace
	
	*Plot the deriv to TotalAsset
	lowess hatvar23 log_asset
	graph export RiskIncomeAsset.png, replace
	
	*Plot the deriv to Years of Education
	lowess hatvar25 HHYearsOfEducation
	graph export RiskIncomeEduc.png, replace
	
	*Table for province
	tab PrvID [aw=pwtxa], sum(hatvar21) means nofreq
	tab PrvID [aw=pwtxa], sum(RiskIncome) means nofreq
	tab PrvID [aw=pwtxa]
	
	*Summary of first derivative
	sum hatvar2*, d
	
	*Mean Square Error
	gen errorsq= (RiskMoney-hatvar21)^2
	sum errorsq
	
	*Region ID
	gen RegID=1 if PrvID>=11 & PrvID<=21
	replace RegID=3 if PrvID>=31 & PrvID<40
	replace RegID=5 if PrvID>=51 & PrvID<60
	replace RegID=6 if PrvID>=61 & PrvID<70
	replace RegID=7 if PrvID>=71 & PrvID<80
	
	tab RegID [aw=pwtxa], sum(hatvar21) means nofreq
	tab RegID [aw=pwtxa], sum(RiskIncome) means nofreq
	save "$pathf/Data/AnalisisRiskIncomeEdit.dta", replace
	
	



 

