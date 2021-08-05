* ==============================================================================
*
* Project			: Lomba paper LPS
* File				: Extract Data from IFLS
* Authors   		: Muhammad Fawdy Renardi Wahyu
* Stata version  	: 14
* Date created		: March 3, 2020
* Last modified  	: July 23, 2020
* Last modified by	: Fawdy
* ==============================================================================

global pathf		"D:\Kerja\Project IFLS"
global ifls5f		"D:\Kerja\Project IFLS\IFLS 5\Data Household Survey"
global ifls5c		"D:\Kerja\Project IFLS\IFLS 5\Data Community Survey"
global ifls4c		"D:\Kerja\Project IFLS\IFLS 4\Community Data"
global ifls4f		"D:\Kerja\Project IFLS\IFLS 4\Household Data"

*Extract B3A_SI IFLS 5
use "$ifls5f/Book 3A/b3a_si.dta", clear
forval i=1/5 {
	rename si0`i' RiskChoose`i'
	lab var RiskChoose`i' si0`i' 
	}
forval i=11/15 {
	rename si`i' RiskChoose`i'
	lab var RiskChoose`i' si`i'
	}
drop stemid module version
rensfix a _1
rensfix b _2
rensfix c _3
rensfix d _4
rensfix e _5
forval i=1/5 {
	rename si21_`i' LotteryChoose21_`i'
	lab var LotteryChoose21_`i' si21_`i'
	rename si22_`i' LotteryChoose22_`i'
	lab var LotteryChoose22_`i' si22_`i'
}
save "$pathf/Data/RiskTime2014.dta", replace

*Extract B3A_SI IFLS 4
use "$ifls4f/b3a_si.dta", clear
forval i=1/5 {
	rename si0`i' RiskChoose`i'
	lab var RiskChoose`i' si0`i' 
	}
forval i=11/15 {
	rename si`i' RiskChoose`i'
	lab var RiskChoose`i' si`i'
	}
drop module version
rensfix a _1
rensfix b _2
rensfix c _3
rensfix d _4
rensfix e _5
forval i=1/5 {
	rename si21_`i' LotteryChoose21_`i'
	lab var LotteryChoose21_`i' si21_`i'
	rename si22_`i' LotteryChoose22_`i'
	lab var LotteryChoose22_`i' si22_`i'
}
save "$pathf/Data/RiskTime2007.dta", replace

*Extract B2HR_1 IFLS 5
use "$ifls5f/Book 2/b2_hr1.dta", clear
generate long hr02=hr02_a if hrtype=="A"
			replace hr02=hr02_b if hrtype=="B"
			replace hr02=hr02_c if hrtype=="C"
			replace hr02=hr02_d1 if hrtype=="D1"
			replace hr02=hr02_d2 if hrtype=="D2"
			replace hr02=hr02_d3 if hrtype=="D3"
			replace hr02=hr02_e if hrtype=="E"
			replace hr02=hr02_f if hrtype=="F"
			replace hr02=hr02_g if hrtype=="G"
			replace hr02=hr02_h if hrtype=="H"
			replace hr02=hr02_j if hrtype=="J"
			replace hr02=hr02_k1 if hrtype=="K1"
			replace hr02=hr02_k2 if hrtype=="K2"
			
			* RECODE THE NUMBER
			*House and Land Assets - code A
			replace hr02=25000000 if hr02p_a==21 | hr02p_a==111 & hrtype=="A"
				replace hr02=50000000 if hr02p_a==22 | hr02p_a==112 & hrtype=="A"
				replace hr02=75000000 if hr02p_a==113 | hr02p_a==231 & hrtype=="A"
				replace hr02=100000000 if hr02p_a==12 | hr02p_a==232 & hrtype=="A"
				replace hr02=150000000 if hr02p_a==131 | hr02p_a==233 | hr02p_a==2331 & hrtype=="A"
				replace hr02=200000000 if hr02p_a==132 | hr02p_a==2332 & hrtype=="A"
				replace hr02=300000000 if hr02p_a==133 | hr02p_a==2333 & hrtype=="A"
			
			*Other House/Building - code B
			replace hr02=25000000 if hr02p_b==21 | hr02p_b==111 & hrtype=="B"
				replace hr02=50000000 if hr02p_b==22 | hr02p_b==112 & hrtype=="B"
				replace hr02=75000000 if hr02p_b==113 | hr02p_b==231 & hrtype=="B"
				replace hr02=100000000 if hr02p_b==12 | hr02p_b==232 & hrtype=="B"
				replace hr02=150000000 if hr02p_b==131 | hr02p_b==233 | hr02p_b==2331 & hrtype=="B"
				replace hr02=200000000 if hr02p_b==132 | hr02p_b==2332 & hrtype=="B"
				replace hr02=300000000 if hr02p_b==133 | hr02p_b==2333 & hrtype=="B"
			
			*Land - code C
			replace hr02=12500000 if hr02p_c==21 | hr02p_c==111 & hrtype=="C"
				replace hr02=25000000 if hr02p_c==22 | hr02p_c==112 & hrtype=="C"
				replace hr02=37500000 if hr02p_c==113 | hr02p_c==231 & hrtype=="C"
				replace hr02=50000000 if hr02p_c==12 | hr02p_c==232 & hrtype=="C"
				replace hr02=750000000 if hr02p_c==131 | hr02p_c==233 | hr02p_c==2331 & hrtype=="C"
				replace hr02=100000000 if hr02p_c==132 | hr02p_c==2332 & hrtype=="C"
				replace hr02=150000000 if hr02p_c==133 | hr02p_c==2333 & hrtype=="C"
			
			*Poultry - code D1
			replace hr02=2000000 if hr02p_d1==21 | hr02p_d1==111 & hrtype=="D1"
				replace hr02=4000000 if hr02p_d1==22 | hr02p_d1==112 & hrtype=="D1"
				replace hr02=6000000 if hr02p_d1==113 | hr02p_d1==231 & hrtype=="D1"
				replace hr02=8000000 if hr02p_d1==12 | hr02p_d1==232 & hrtype=="D1"
				replace hr02=11500000 if hr02p_d1==131 | hr02p_d1==233 | hr02p_d1==2331 & hrtype=="D1"
				replace hr02=15000000 if hr02p_d1==132 | hr02p_d1==2332 & hrtype=="D1"
				replace hr02=20000000 if hr02p_d1==133 | hr02p_d1==2333 & hrtype=="D1"
			
			*Livestock/Fishpond - code D2
			replace hr02=2000000 if hr02p_d2==21 | hr02p_d2==111 & hrtype=="D2"
				replace hr02=4000000 if hr02p_d2==22 | hr02p_d2==112 & hrtype=="D2"
				replace hr02=6000000 if hr02p_d2==113 | hr02p_d2==231 & hrtype=="D2"
				replace hr02=8000000 if hr02p_d2==12 | hr02p_d2==232 & hrtype=="D2"
				replace hr02=11500000 if hr02p_d2==131 | hr02p_d2==233 | hr02p_d2==2331 & hrtype=="D2"
				replace hr02=15000000 if hr02p_d2==132 | hr02p_d2==2332 & hrtype=="D2"
				replace hr02=20000000 if hr02p_d2==133 | hr02p_d2==2333 & hrtype=="D2"
			
			*Hard Stem Plant - code D3
			replace hr02=5000000 if hr02p_d3==21 | hr02p_d3==111 & hrtype=="D3"
				replace hr02=10000000 if hr02p_d3==22 | hr02p_d3==112 & hrtype=="D3"
				replace hr02=15000000 if hr02p_d3==113 | hr02p_d3==231 & hrtype=="D3"
				replace hr02=20000000 if hr02p_d3==12 | hr02p_d3==232 & hrtype=="D3"
				replace hr02=30000000 if hr02p_d3==131 | hr02p_d3==233 | hr02p_d3==2331 & hrtype=="D3"
				replace hr02=40000000 if hr02p_d3==132 | hr02p_d3==2332 & hrtype=="D3"
				replace hr02=60000000 if hr02p_d3==133 | hr02p_d3==2333 & hrtype=="D3"
			
			*Vehicles - code E
			replace hr02=2500000 if hr02p_e==21 | hr02p_e==111 & hrtype=="E"
				replace hr02=5000000 if hr02p_e==22 | hr02p_e==112 & hrtype=="E"
				replace hr02=75000000 if hr02p_e==113 | hr02p_e==231 & hrtype=="E"
				replace hr02=10000000 if hr02p_e==12 | hr02p_e==232 & hrtype=="E"
				replace hr02=30000000 if hr02p_e==131 | hr02p_e==233 | hr02p_e==2331 & hrtype=="E"
				replace hr02=50000000 if hr02p_e==132 | hr02p_e==2332 & hrtype=="E"
				replace hr02=70000000 if hr02p_e==133 | hr02p_e==2333 & hrtype=="E"
			
			*Household Appliances - code F
			replace hr02=2000000 if hr02p_f==21 | hr02p_f==111 & hrtype=="F"
				replace hr02=4000000 if hr02p_f==22 | hr02p_f==112 & hrtype=="F"
				replace hr02=6000000 if hr02p_f==113 | hr02p_f==231 & hrtype=="F"
				replace hr02=8000000 if hr02p_f==12 | hr02p_f==232 & hrtype=="F"
				replace hr02=11500000 if hr02p_f==131 | hr02p_f==233 | hr02p_f==2331 & hrtype=="F"
				replace hr02=15000000 if hr02p_f==132 | hr02p_f==2332 & hrtype=="F"
				replace hr02=20000000 if hr02p_f==133 | hr02p_f==2333 & hrtype=="F"
			
			*Savings - code G
			replace hr02=2000000 if hr02p_g==21 | hr02p_g==111 & hrtype=="G"
				replace hr02=4000000 if hr02p_g==22 | hr02p_g==112 & hrtype=="G"
				replace hr02=6000000 if hr02p_g==113 | hr02p_g==231 & hrtype=="G"
				replace hr02=8000000 if hr02p_g==12 | hr02p_g==232 & hrtype=="G"
				replace hr02=11500000 if hr02p_g==131 | hr02p_g==233 | hr02p_g==2331 & hrtype=="G"
				replace hr02=15000000 if hr02p_g==132 | hr02p_g==2332 & hrtype=="G"
				replace hr02=20000000 if hr02p_g==133 | hr02p_g==2333 & hrtype=="G"
			
			*Receivables - code H
			replace hr02=2500000 if hr02p_h==21 | hr02p_h==111 & hrtype=="H"
				replace hr02=5000000 if hr02p_h==22 | hr02p_h==112 & hrtype=="H"
				replace hr02=7500000 if hr02p_h==113 | hr02p_h==231 & hrtype=="H"
				replace hr02=10000000 if hr02p_h==12 | hr02p_h==232 & hrtype=="H"
				replace hr02=12500000 if hr02p_h==131 | hr02p_h==233 | hr02p_h==2331 & hrtype=="H"
				replace hr02=25000000 if hr02p_h==132 | hr02p_h==2332 & hrtype=="H"
				replace hr02=32500000 if hr02p_h==133 | hr02p_h==2333 & hrtype=="H"
			
			*Jewelry - code J
			replace hr02=3000000 if hr02p_j==21 | hr02p_j==111 & hrtype=="J"
				replace hr02=4000000 if hr02p_j==22 | hr02p_j==112 & hrtype=="J"
				replace hr02=5000000 if hr02p_j==113 | hr02p_j==231 & hrtype=="J"
				replace hr02=6000000 if hr02p_j==12 | hr02p_j==232 & hrtype=="J"
				replace hr02=8000000 if hr02p_j==131 | hr02p_j==233 | hr02p_j==2331 & hrtype=="J"
				replace hr02=10000000 if hr02p_j==132 | hr02p_j==2332 & hrtype=="J"
				replace hr02=12000000 if hr02p_j==133 | hr02p_j==2333 & hrtype=="J"
			
			*Furniture - code K1
			replace hr02=3000000 if hr02p_k1==21 | hr02p_k1==111 & hrtype=="K1"
				replace hr02=4000000 if hr02p_k1==22 | hr02p_k1==112 & hrtype=="K1"
				replace hr02=5000000 if hr02p_k1==113 | hr02p_k1==231 & hrtype=="K1"
				replace hr02=6000000 if hr02p_k1==12 | hr02p_k1==232 & hrtype=="K1"
				replace hr02=8000000 if hr02p_k1==131 | hr02p_k1==233 | hr02p_k1==2331 & hrtype=="K1"
				replace hr02=10000000 if hr02p_k1==132 | hr02p_k1==2332 & hrtype=="K1"
				replace hr02=12000000 if hr02p_k1==133 | hr02p_k1==2333 & hrtype=="K1"
			
			*Other - code K2
			replace hr02=3000000 if hr02p_k2==21 | hr02p_k2==111 & hrtype=="K2"
				replace hr02=4000000 if hr02p_k2==22 | hr02p_k2==112 & hrtype=="K2"
				replace hr02=5000000 if hr02p_k2==113 | hr02p_k2==231 & hrtype=="K2"
				replace hr02=6000000 if hr02p_k2==12 | hr02p_k2==232 & hrtype=="K2"
				replace hr02=8000000 if hr02p_k2==131 | hr02p_k2==233 | hr02p_k2==2331 & hrtype=="K2"
				replace hr02=10000000 if hr02p_k2==132 | hr02p_k2==2332 & hrtype=="K2"
				replace hr02=12000000 if hr02p_k2==133 | hr02p_k2==2333 & hrtype=="K2"
		
		keep hhid14 hrtype hr02
		replace hr02=0 if hr02==.
		
		replace hrtype="HouseLand" if hrtype=="A"
			replace hrtype="House" if hrtype=="B"
			replace hrtype="Land" if hrtype=="C"
			replace hrtype="Poultry" if hrtype=="D1"
			replace hrtype="Livestock" if hrtype=="D2"
			replace hrtype="Plant" if hrtype=="D3"
			replace hrtype="Vehicles" if hrtype=="E"
			replace hrtype="Appliances" if hrtype=="F"
			replace hrtype="Saving" if hrtype=="G"
			replace hrtype="Receivable" if hrtype=="H"
			replace hrtype="Jewelry" if hrtype=="J"
			replace hrtype="Furniture" if hrtype=="K1"
			replace hrtype="Other" if hrtype=="K2"
		
		bys hhid14: egen long TotalAsset=sum(hr02)
		
		rename hr02 ValueAsset
		
		reshape wide ValueAsset, i(hhid14 TotalAsset) j(hrtype) string
save "$pathf/Data/HouseholdAsset2014.dta", replace

*Extract B2HR_1 IFLS 4
use "$ifls4f/b2_hr1.dta", clear
generate long hr02y=hr02 if hrtype=="A"
			replace hr02y=hr02 if hrtype=="B"
			replace hr02y=hr02 if hrtype=="C"
			replace hr02y=hr02 if hrtype=="D1"
			replace hr02y=hr02 if hrtype=="D2"
			replace hr02y=hr02 if hrtype=="D3"
			replace hr02y=hr02 if hrtype=="E"
			replace hr02y=hr02 if hrtype=="F"
			replace hr02y=hr02 if hrtype=="G"
			replace hr02y=hr02 if hrtype=="H"
			replace hr02y=hr02 if hrtype=="J"
			replace hr02y=hr02 if hrtype=="K1"
			replace hr02y=hr02 if hrtype=="K2"
		
	* RECODE THE NUMBER
			*House and Land Assets - code A
			replace hr02y=45000000 if hr02p2==11 & hrtype=="A"
				replace hr02y=35000000 if hr02p2==12 & hrtype=="A"
				replace hr02y=25000000 if hr02p1==1 & hrtype=="A"
				replace hr02y=15000000 if hr02p1==2 | hr02p2==21 & hrtype=="A"
				replace hr02y=5000000 if hr02p2==22 & hrtype=="A"
			*Other House/Building - code B
			replace hr02y=45000000 if hr02p2==11 & hrtype=="B"
				replace hr02y=35000000 if hr02p2==12 & hrtype=="B"
				replace hr02y=25000000 if hr02p1==1 & hrtype=="B"
				replace hr02y=15000000 if hr02p1==2 | hr02p2==21 & hrtype=="B"
				replace hr02y=5000000 if hr02p2==22 & hrtype=="B"
			*Land - code C
			replace hr02y=45000000 if hr02p2==11 & hrtype=="C"
				replace hr02y=35000000 if hr02p2==12 & hrtype=="C"
				replace hr02y=25000000 if hr02p1==1 & hrtype=="C"
				replace hr02y=15000000 if hr02p1==2 | hr02p2==21 & hrtype=="C"
				replace hr02y=5000000 if hr02p2==22 & hrtype=="C"
			*Savings - code G
			replace hr02y=9000000 if hr02p2==11 & hrtype=="G"
				replace hr02y=7000000 if hr02p2==12 & hrtype=="G"
				replace hr02y=5000000 if hr02p1==1 & hrtype=="G"
				replace hr02y=3000000 if hr02p1==2 | hr02p2==21 & hrtype=="G"
				replace hr02y=1000000 if hr02p2==22 & hrtype=="G"
			*Jewelry - code J
			replace hr02y=9000000 if hr02p2==11 & hrtype=="J"
				replace hr02y=7000000 if hr02p2==12 & hrtype=="J"
				replace hr02y=5000000 if hr02p1==1 & hrtype=="J"
				replace hr02y=3000000 if hr02p1==2 | hr02p2==21 & hrtype=="J"
				replace hr02y=1000000 if hr02p2==22 & hrtype=="J"
		
		keep hhid07 hrtype hr02y
		replace hr02y=0 if hr02y==.
		
		replace hrtype="HouseLand" if hrtype=="A"
			replace hrtype="House" if hrtype=="B"
			replace hrtype="Land" if hrtype=="C"
			replace hrtype="Poultry" if hrtype=="D1"
			replace hrtype="Livestock" if hrtype=="D2"
			replace hrtype="Plant" if hrtype=="D3"
			replace hrtype="Vehicles" if hrtype=="E"
			replace hrtype="Appliances" if hrtype=="F"
			replace hrtype="Saving" if hrtype=="G"
			replace hrtype="Receivable" if hrtype=="H"
			replace hrtype="Jewelry" if hrtype=="J"
			replace hrtype="Furniture" if hrtype=="K1"
			replace hrtype="Other" if hrtype=="K2"
		
		bys hhid07: egen long TotalAsset=sum(hr02y)
		
		rename hr02y ValueAsset
		
		reshape wide ValueAsset, i(hhid07 TotalAsset) j(hrtype) string

save "$pathf/Data/HouseholdAsset2007.dta", replace

*Extract BK_AR IFLS 5
use "$ifls5f/Book K/bk_ar1.dta", clear
*Head of HH Charasteristics
			/* rename ar15a HeadOfHHWork				//generate dummy work
			replace HeadOfHHWork=0 if HeadOfHHWork!=1
			
			rename ar15c HeadOfHHWorkStatus			//generate dummy work status
			
			rename ar13 MaritalStatus				//generate dummy Marital Status
			
			rename ar09 HeadOfHHAge					//generate head of HH Age
			
			rename ar07 HeadOfHHSex					//generate Head of HH Sex
			replace HeadOfHHSex=0 if HeadOfHHSex==3
		
			generate HeadOfHHHighestEduc=0 if ar16==2 | ar16==17 | ar16==72 | ar16==11						//Generate Head  of Household Years of Education
				replace HeadOfHHHighestEduc=6 if ar16==3 | ar16==4 | ar16==73 | ar16==12
				replace HeadOfHHHighestEduc=9 if ar16==5 | ar16==6 | ar16==74 | ar16==15 | ar16==14
				replace HeadOfHHHighestEduc=12 if ar16==13 | ar16==60 | ar16==61
				replace HeadOfHHHighestEduc=16 if ar16==62
				
				replace ar17=0 if ar17==96 | ar17==98
				
				generate HeadOfHHYearsOfEducation=HeadOfHHHighestEduc+ar17
				replace HeadOfHHYearsOfEducation=6 if HeadOfHHHighestEduc==0 & ar17==7
				replace HeadOfHHYearsOfEducation=9  if HeadOfHHHighestEduc==6 & ar17==7
				replace HeadOfHHYearsOfEducation=12  if HeadOfHHHighestEduc==9 & ar17==7
				replace HeadOfHHYearsOfEducation=16  if HeadOfHHHighestEduc==12 & ar17==7
				replace HeadOfHHYearsOfEducation=18  if HeadOfHHHighestEduc==16 & ar17==7
				replace HeadOfHHYearsOfEducation=21  if HeadOfHHHighestEduc==18 & ar17==7
				
				replace HeadOfHHYearsOfEducation=0 if ar16==1 | ar16==90 | ar16==98
				label var HeadOfHHYearsOfEducation "Head of Household Years of Education"
			
			rename ar15b HeadOfHHEarning			//Generate Income Variable
				replace HeadOfHHEarning=0 if HeadOfHHEarning==. & HeadOfHHWork==0
			
			*Household Composition
			drop if ar18d==0 | ar18d==3								//drop split hpusehold member
			
			generate byte Child=HeadOfHHAge<=15						//Count HH Member Age <=15
				bys hhid14: egen NumberChild=sum(Child)
				label var NumberChild "Total Number of Children"
			
			generate byte HHMember=1								//Count Household Size
				bys hhid14: egen NumberMember=sum(HHMember)
				label var NumberMember "Household Size"
			
			bys hhid14: egen NumberWorkMember=sum(HeadOfHHWork)		//Count Number of Working Member
				label var NumberWorkMember "Number of Working Member"
			
			bys hhid14: egen long TotalEarning=sum(HeadOfHHEarning)
				label var TotalEarning "Total Earning Within Household"
			
			*Keep Head of Household Data Only
			keep if ar02b==1						//keep head of household only
			
			*Keep only Relevant Variables
			keep hhid14 pid14 pidlink HeadOfHHWork HeadOfHHWorkStatus MaritalStatus ///
				HeadOfHHAge HeadOfHHSex HeadOfHHYearsOfEducation NumberMember ///
				NumberWorkMember TotalEarning HeadOfHHEarning
save "$pathf/Data/HeadofHHCharacteristics2014.dta", replace */

	*Household Member
	use "$ifls5f/Book K/bk_ar1.dta", clear
			rename ar15a HeadOfHHWork
			replace HeadOfHHWork=0 if HeadOfHHWork!=1
			
			rename ar15c HeadOfHHWorkStatus			//generate dummy work status
			
			rename ar13 MaritalStatus				//generate dummy Marital Status
			
			rename ar09 HeadOfHHAge					//generate head of HH Age
			
			rename ar07 HeadOfHHSex					//generate Head of HH Sex
			replace HeadOfHHSex=0 if HeadOfHHSex==3
		
			generate HeadOfHHHighestEduc=0 if ar16==2 | ar16==17 | ar16==72 | ar16==11						//Generate Head  of Household Years of Education
				replace HeadOfHHHighestEduc=6 if ar16==3 | ar16==4 | ar16==73 | ar16==12
				replace HeadOfHHHighestEduc=9 if ar16==5 | ar16==6 | ar16==74 | ar16==15 | ar16==14
				replace HeadOfHHHighestEduc=12 if ar16==13 | ar16==60 | ar16==61
				replace HeadOfHHHighestEduc=16 if ar16==62
				
				replace ar17=0 if ar17==96 | ar17==98
				
				generate HeadOfHHYearsOfEducation=HeadOfHHHighestEduc+ar17
				replace HeadOfHHYearsOfEducation=6 if HeadOfHHHighestEduc==0 & ar17==7
				replace HeadOfHHYearsOfEducation=9  if HeadOfHHHighestEduc==6 & ar17==7
				replace HeadOfHHYearsOfEducation=12  if HeadOfHHHighestEduc==9 & ar17==7
				replace HeadOfHHYearsOfEducation=16  if HeadOfHHHighestEduc==12 & ar17==7
				replace HeadOfHHYearsOfEducation=18  if HeadOfHHHighestEduc==16 & ar17==7
				replace HeadOfHHYearsOfEducation=21  if HeadOfHHHighestEduc==18 & ar17==7
				
				replace HeadOfHHYearsOfEducation=0 if ar16==1 | ar16==90 | ar16==98
				label var HeadOfHHYearsOfEducation "Head of Household Years of Education"
			
			rename ar15b HeadOfHHEarning			//Generate Income Variable
				replace HeadOfHHEarning=0 if HeadOfHHEarning==. & HeadOfHHWork==0
				
				rename HeadOfHHWork HHWork
				rename HeadOfHHWorkStatus HHWorkStatus
				rename HeadOfHHEarning HHEarning
				rename HeadOfHHSex HHSex
				rename HeadOfHHAge HHAge
				rename HeadOfHHHighestEduc HHHighestEduc
				rename HeadOfHHYearsOfEducation HHYearsOfEducation
			
			*Household Composition
			drop if ar18d==0 | ar18d==3								//drop split hpusehold member
			
			generate byte Child=HHAge<=15						//Count HH Member Age <=15
				bys hhid14: egen NumberChild=sum(Child)
				label var NumberChild "Total Number of Children"
			
			generate byte HHMember=1								//Count Household Size
				bys hhid14: egen NumberMember=sum(HHMember)
				label var NumberMember "Household Size"
			
			bys hhid14: egen NumberWorkMember=sum(HHWork)		//Count Number of Working Member
				label var NumberWorkMember "Number of Working Member"
			
			bys hhid14: egen long TotalEarning=sum(HHEarning)
				label var TotalEarning "Total Earning Within Household"
			
			*Keep only Relevant Variables
			keep hhid14 pid14 pidlink HHWork HHWorkStatus MaritalStatus ///
				HHAge HHSex HHYearsOfEducation NumberMember ///
				NumberWorkMember TotalEarning HHEarning
				
			save "$pathf/Data/HHCharacteristics2014.dta", replace
			
		*House Characteristics
		use "$ifls5f/Book K/bk_krk.dta", clear
		
			rename krk01 HouseType
			rename krk02a HouseSanitary1
			rename krk02b HouseSanitary2
			rename krk02c HouseSanitary3
			rename krk02d HouseSanitary4
			rename krk02e HouseSanitary5
			rename krk02f HouseSanitary6
			rename krk02g HouseSanitary7
			rename krk02h HouseSanitary8
			rename krk02i HouseSanitary9
			rename krk05a HouseSize
			rename krk06 HouseNumberOfRooms
			rename krk08 HouseFloor
			rename krk09 HouseWalls
			rename krk10 HouseRoof
			
			*keep only relevant variables
			keep hhid14 House*
			
			save "$pathf/Data/HouseCharacteristics2014.dta", replace
			
		*Health Condition
		use "$ifls5f/Book 3B/b3b_kk1.dta", clear
		
		rename kk01 HealthCondition
		rename kk02a HealthPoorDays
		rename kk02b HealthPoorBedDays
		rename kk02c HealthComparison12Months
		rename kk02i HealthExpectation1year
		rename kk02k HealthComparisonPerson
		rename kk02l HealthExpectation5year
		
		keep hhid14 pid14 pidlink Health*
			
		save "$pathf/Data/HealthCondition2014.dta", replace
		
				
	*Spouse Head of HH Characteristics
		/* use "$ifls5f/Book K/bk_ar1.dta", clear
			
			*Head of HH Charasteristics
			rename ar15a SpouseHeadOfHHWork				//generate dummy work
			replace SpouseHeadOfHHWork=0 if SpouseHeadOfHHWork!=1
			
			rename ar15c SpouseHeadOfHHWorkStatus			//generate dummy work status
			
			rename ar13 SpouseMaritalStatus				//generate dummy Marital Status
			
			rename ar09 SpouseHeadOfHHAge					//generate head of HH Age
			
			rename ar07 SpouseHeadOfHHSex					//generate Head of HH Sex
			replace SpouseHeadOfHHSex=0 if SpouseHeadOfHHSex==3
		
			generate SpouseHeadOfHHHighestEduc=0 if ar16==2 | ar16==17 | ar16==72 | ar16==11						//Generate Head  of Household Years of Education
				replace SpouseHeadOfHHHighestEduc=6 if ar16==3 | ar16==4 | ar16==73 | ar16==12
				replace SpouseHeadOfHHHighestEduc=9 if ar16==5 | ar16==6 | ar16==74 | ar16==15 | ar16==14
				replace SpouseHeadOfHHHighestEduc=12 if ar16==13 | ar16==60 | ar16==61
				replace SpouseHeadOfHHHighestEduc=16 if ar16==62
				
				replace ar17=0 if ar17==96 | ar17==98
				
				generate SpouseHeadOfHHYearsOfEducation=SpouseHeadOfHHHighestEduc+ar17
				replace SpouseHeadOfHHYearsOfEducation=6 if SpouseHeadOfHHHighestEduc==0 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=9  if SpouseHeadOfHHHighestEduc==6 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=12  if SpouseHeadOfHHHighestEduc==9 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=16  if SpouseHeadOfHHHighestEduc==12 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=18  if SpouseHeadOfHHHighestEduc==16 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=21  if SpouseHeadOfHHHighestEduc==18 & ar17==7
				
				replace SpouseHeadOfHHYearsOfEducation=0 if ar16==1 | ar16==90 | ar16==98
				label var SpouseHeadOfHHYearsOfEducation "Spouse Head of Household Years of Education"
			
			rename ar15b SpouseHeadOfHHEarning			//Generate Income Variable
				replace SpouseHeadOfHHEarning=0 if SpouseHeadOfHHEarning==. & SpouseHeadOfHHWork==0
			
			keep if ar02b==2										//Keep only Oldest Spouse
				generate Spouse=1
				bys hhid14: egen NumberOfSpouse=sum(Spouse)
				bys hhid14: egen MaxAgeSpouse=max(SpouseHeadOfHHAge)
				keep if MaxAgeSpouse==SpouseHeadOfHHAge
			
			rename pid14 SpouseID
			
			keep hhid14 pidlink SpouseID SpouseHeadOfHHWork SpouseHeadOfHHWorkStatus SpouseMaritalStatus ///
				SpouseHeadOfHHAge SpouseHeadOfHHSex SpouseHeadOfHHYearsOfEducation SpouseHeadOfHHEarning
			
			save "$pathf/Data/SpouseHeadOfHHData14.dta", replace */

*Extract BK_AR IFLS 4
*use "$ifls4f/bk_ar1.dta", clear
	*Head of HH Charasteristics
			/* rename ar15a HeadOfHHWork				//generate dummy work
			replace HeadOfHHWork=0 if HeadOfHHWork!=1
			
			rename ar15c HeadOfHHWorkStatus			//generate dummy work status
			
			rename ar13 MaritalStatus				//generate dummy Marital Status
			
			rename ar09 HeadOfHHAge					//generate head of HH Age
			
			rename ar07 HeadOfHHSex					//generate Head of HH Sex
			replace HeadOfHHSex=0 if HeadOfHHSex==3
		
			generate HeadOfHHHighestEduc=0 if ar16==2 | ar16==17 | ar16==72 | ar16==11						//Generate Head  of Household Years of Education
				replace HeadOfHHHighestEduc=6 if ar16==3 | ar16==4 | ar16==73 | ar16==12
				replace HeadOfHHHighestEduc=9 if ar16==5 | ar16==6 | ar16==74 | ar16==15 | ar16==14
				replace HeadOfHHHighestEduc=12 if ar16==13 | ar16==60 | ar16==61
				replace HeadOfHHHighestEduc=16 if ar16==62
				
				replace ar17=0 if ar17==96 | ar17==98
				
				generate HeadOfHHYearsOfEducation=HeadOfHHHighestEduc+ar17
				replace HeadOfHHYearsOfEducation=6 if HeadOfHHHighestEduc==0 & ar17==7
				replace HeadOfHHYearsOfEducation=9  if HeadOfHHHighestEduc==6 & ar17==7
				replace HeadOfHHYearsOfEducation=12  if HeadOfHHHighestEduc==9 & ar17==7
				replace HeadOfHHYearsOfEducation=16  if HeadOfHHHighestEduc==12 & ar17==7
				replace HeadOfHHYearsOfEducation=18  if HeadOfHHHighestEduc==16 & ar17==7
				replace HeadOfHHYearsOfEducation=21  if HeadOfHHHighestEduc==18 & ar17==7
				
				replace HeadOfHHYearsOfEducation=0 if ar16==1 | ar16==90 | ar16==98
				label var HeadOfHHYearsOfEducation "Head of Household Years of Education"
			
			rename ar15b HeadOfHHEarning			//Generate Income Variable
				replace HeadOfHHEarning=0 if HeadOfHHEarning==. & HeadOfHHWork==0
			
			*Household Composition
			drop if ar18d==0 | ar18d==3								//drop split hpusehold member
			
			generate byte Child=HeadOfHHAge<=15						//Count HH Member Age <=15
				bys hhid07: egen NumberChild=sum(Child)
				label var NumberChild "Total Number of Children"
			
			generate byte HHMember=1								//Count Household Size
				bys hhid07: egen NumberMember=sum(HHMember)
				label var NumberMember "Household Size"
			
			bys hhid07: egen NumberWorkMember=sum(HeadOfHHWork)		//Count Number of Working Member
				label var NumberWorkMember "Number of Working Member"
			
			bys hhid07: egen long TotalEarning=sum(HeadOfHHEarning)
				label var TotalEarning "Total Earning Within Household"
			
			*Keep Head of Household Data Only
			keep if ar02b==1						//keep head of household only
			
			*Keep only Relevant Variables
			keep hhid07 pid07 pidlink HeadOfHHWork HeadOfHHWorkStatus MaritalStatus ///
				HeadOfHHAge HeadOfHHSex HeadOfHHYearsOfEducation NumberMember ///
				NumberWorkMember TotalEarning HeadOfHHEarning
save "$pathf/Data/HeadofHHCharacteristics2007.dta", replace */

		*Household Member 2007
		use "$ifls4f/bk_ar1.dta", clear
			rename ar15a HeadOfHHWork
			replace HeadOfHHWork=0 if HeadOfHHWork!=1
			
			rename ar15c HeadOfHHWorkStatus			//generate dummy work status
			
			rename ar13 MaritalStatus				//generate dummy Marital Status
			
			rename ar09 HeadOfHHAge					//generate head of HH Age
			
			rename ar07 HeadOfHHSex					//generate Head of HH Sex
			replace HeadOfHHSex=0 if HeadOfHHSex==3
		
			generate HeadOfHHHighestEduc=0 if ar16==2 | ar16==17 | ar16==72 | ar16==11						//Generate Head  of Household Years of Education
				replace HeadOfHHHighestEduc=6 if ar16==3 | ar16==4 | ar16==73 | ar16==12
				replace HeadOfHHHighestEduc=9 if ar16==5 | ar16==6 | ar16==74 | ar16==15 | ar16==14
				replace HeadOfHHHighestEduc=12 if ar16==13 | ar16==60 | ar16==61
				replace HeadOfHHHighestEduc=16 if ar16==62
				
				replace ar17=0 if ar17==96 | ar17==98
				
				generate HeadOfHHYearsOfEducation=HeadOfHHHighestEduc+ar17
				replace HeadOfHHYearsOfEducation=6 if HeadOfHHHighestEduc==0 & ar17==7
				replace HeadOfHHYearsOfEducation=9  if HeadOfHHHighestEduc==6 & ar17==7
				replace HeadOfHHYearsOfEducation=12  if HeadOfHHHighestEduc==9 & ar17==7
				replace HeadOfHHYearsOfEducation=16  if HeadOfHHHighestEduc==12 & ar17==7
				replace HeadOfHHYearsOfEducation=18  if HeadOfHHHighestEduc==16 & ar17==7
				replace HeadOfHHYearsOfEducation=21  if HeadOfHHHighestEduc==18 & ar17==7
				
				replace HeadOfHHYearsOfEducation=0 if ar16==1 | ar16==90 | ar16==98
				label var HeadOfHHYearsOfEducation "Head of Household Years of Education"
			
			rename ar15b HeadOfHHEarning			//Generate Income Variable
				replace HeadOfHHEarning=0 if HeadOfHHEarning==. & HeadOfHHWork==0
				
				rename HeadOfHHWork HHWork
				rename HeadOfHHWorkStatus HHWorkStatus
				rename HeadOfHHEarning HHEarning
				rename HeadOfHHSex HHSex
				rename HeadOfHHAge HHAge
				rename HeadOfHHHighestEduc HHHighestEduc
				rename HeadOfHHYearsOfEducation HHYearsOfEducation
			
			*Household Composition
			drop if ar18d==0 | ar18d==3								//drop split hpusehold member
			
			generate byte Child=HHAge<=15						//Count HH Member Age <=15
				bys hhid07: egen NumberChild=sum(Child)
				label var NumberChild "Total Number of Children"
			
			generate byte HHMember=1								//Count Household Size
				bys hhid07: egen NumberMember=sum(HHMember)
				label var NumberMember "Household Size"
			
			bys hhid07: egen NumberWorkMember=sum(HHWork)		//Count Number of Working Member
				label var NumberWorkMember "Number of Working Member"
			
			bys hhid07: egen long TotalEarning=sum(HHEarning)
				label var TotalEarning "Total Earning Within Household"
			
			*Keep only Relevant Variables
			keep hhid07 pid07 pidlink HHWork HHWorkStatus MaritalStatus ///
				HHAge HHSex HHYearsOfEducation NumberMember ///
				NumberWorkMember TotalEarning HHEarning
				
			save "$pathf/Data/HHCharacteristics2007.dta", replace
			
		*House Characteristics
		use "$ifls4f/bk_krk.dta", clear
		
			rename krk01 HouseType
			rename krk02a HouseSanitary1
			rename krk02b HouseSanitary2
			rename krk02c HouseSanitary3
			rename krk02d HouseSanitary4
			rename krk02e HouseSanitary5
			rename krk02f HouseSanitary6
			rename krk02g HouseSanitary7
			rename krk02h HouseSanitary8
			rename krk02i HouseSanitary9
			rename krk05a HouseSize
			rename krk06 HouseNumberOfRooms
			rename krk08 HouseFloor
			rename krk09 HouseWalls
			rename krk10 HouseRoof
			
			*keep only relevant variables
			keep hhid07 House*
			
			save "$pathf/Data/HouseCharacteristics2007.dta", replace
			
		*Health Condition
		use "$ifls4f/b3b_kk1.dta", clear
		
		rename kk01 HealthCondition
		rename kk02a HealthPoorDays
		rename kk02b HealthPoorBedDays
		rename kk02c HealthComparison12Months
		rename kk02i HealthExpectation1year
		rename kk02k HealthComparisonPerson
		rename kk02l HealthExpectation5year
		
		keep hhid07 pid07 pidlink Health*
			
		save "$pathf/Data/HealthCondition2007.dta", replace

*Spouse Head of HH Characteristics
		/* use "$ifls4f/bk_ar1.dta", clear
			
			*Head of HH Charasteristics
			rename ar15a SpouseHeadOfHHWork				//generate dummy work
			replace SpouseHeadOfHHWork=0 if SpouseHeadOfHHWork!=1
			
			rename ar15c SpouseHeadOfHHWorkStatus			//generate dummy work status
			
			rename ar13 SpouseMaritalStatus				//generate dummy Marital Status
			
			rename ar09 SpouseHeadOfHHAge					//generate head of HH Age
			
			rename ar07 SpouseHeadOfHHSex					//generate Head of HH Sex
			replace SpouseHeadOfHHSex=0 if SpouseHeadOfHHSex==3
		
			generate SpouseHeadOfHHHighestEduc=0 if ar16==2 | ar16==17 | ar16==72 | ar16==11						//Generate Head  of Household Years of Education
				replace SpouseHeadOfHHHighestEduc=6 if ar16==3 | ar16==4 | ar16==73 | ar16==12
				replace SpouseHeadOfHHHighestEduc=9 if ar16==5 | ar16==6 | ar16==74 | ar16==15 | ar16==14
				replace SpouseHeadOfHHHighestEduc=12 if ar16==13 | ar16==60 | ar16==61
				replace SpouseHeadOfHHHighestEduc=16 if ar16==62
				
				replace ar17=0 if ar17==96 | ar17==98
				
				generate SpouseHeadOfHHYearsOfEducation=SpouseHeadOfHHHighestEduc+ar17
				replace SpouseHeadOfHHYearsOfEducation=6 if SpouseHeadOfHHHighestEduc==0 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=9  if SpouseHeadOfHHHighestEduc==6 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=12  if SpouseHeadOfHHHighestEduc==9 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=16  if SpouseHeadOfHHHighestEduc==12 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=18  if SpouseHeadOfHHHighestEduc==16 & ar17==7
				replace SpouseHeadOfHHYearsOfEducation=21  if SpouseHeadOfHHHighestEduc==18 & ar17==7
				
				replace SpouseHeadOfHHYearsOfEducation=0 if ar16==1 | ar16==90 | ar16==98
				label var SpouseHeadOfHHYearsOfEducation "Spouse Head of Household Years of Education"
			
			rename ar15b SpouseHeadOfHHEarning			//Generate Income Variable
				replace SpouseHeadOfHHEarning=0 if SpouseHeadOfHHEarning==. & SpouseHeadOfHHWork==0
			
			keep if ar02b==2										//Keep only Oldest Spouse
				generate Spouse=1
				bys hhid07: egen NumberOfSpouse=sum(Spouse)
				bys hhid07: egen MaxAgeSpouse=max(SpouseHeadOfHHAge)
				keep if MaxAgeSpouse==SpouseHeadOfHHAge
			
			rename pid07 SpouseID
			duplicates tag hhid07, g(tag)
			drop if tag==1
			drop tag
			
			keep hhid07 pidlink SpouseID SpouseHeadOfHHWork SpouseHeadOfHHWorkStatus SpouseMaritalStatus ///
				SpouseHeadOfHHAge SpouseHeadOfHHSex SpouseHeadOfHHYearsOfEducation SpouseHeadOfHHEarning
			
			save "$pathf/Data/SpouseHeadOfHHData07.dta", replace */


*Extract B3A_DL IFLS 5
use "$ifls5f/Book 3A/b3a_dl1.dta", clear
keep hhid14_9 pid14 hhid14 pidlink dl02 dl02a dl03 dl03a dl03b dl03c dl03d dl03e
rename dl02 LiteracyNewspaperIna
rename dl02a LiteracyNewspaperAsing
rename dl03 LiteracyWriteIna
rename dl03a LiteracyWriteAsing
rename dl03b LiteracyCellphone
rename dl03c LiteracyCellphoneUse
rename dl03d LiteracyInternet
rename dl03e LiteracyInternetSource
save "$pathf/Data/Literacy2014.dta", replace

*Extract B3A_DL IFLS 4
use "$ifls4f/b3a_dl1.dta", clear
keep pid07 hhid07 pidlink dl02 dl02a dl03 dl03a
rename dl02 LiteracyNewspaperIna
rename dl02a LiteracyNewspaperAsing
rename dl03 LiteracyWriteIna
rename dl03a LiteracyWriteAsing
save "$pathf/Data/Literacy2007.dta", replace

*Extract BK1_G IFLS 5 (Community Bank)
use "$ifls5c/bk1_g.dta", clear
generate BRIDistance1=g3b if gtype==1														//generate financial service distance
			bys commid: egen BRIDistance=max(BRIDistance1)
			generate byte MissBRIDist=BRIDistance==.
			replace BRIDistance=200 if BRIDistance==.
			label var BRIDistance "Kilometers from community center to Bank Rakyat Indonesia"
			
		generate BPRDistance1=g3b if gtype==2
			bys commid: egen BPRDistance=max(BPRDistance1)
			generate byte MissBPRDist=BPRDistance==.
			replace BPRDistance=200 if BPRDistance==.
			label var BPRDistance "Kilometers from community center to People Credit Bank"
		
		generate LKDDistance1=g3b if gtype==3
			bys commid: egen LKDDistance=max(LKDDistance1)
			generate byte MissLKDDist=LKDDistance==.
			replace LKDDistance=200 if LKDDistance==.
			label var LKDDistance "Kilometers from community center to Village Credit Institution"
			
		generate KUDDistance1=g3b if gtype==4
			bys commid: egen KUDDistance=max(KUDDistance1)
			generate byte MissKUDDist=KUDDistance==.
			replace KUDDistance=200 if KUDDistance==.
			label var KUDDistance "Kilometers from community center to Village Unit Cooperative"
		
		generate CoopDistance1=g3b if gtype==5
			bys commid: egen CoopDistance=max(CoopDistance1)
			generate byte MissCoopDist=CoopDistance==.
			replace CoopDistance=200 if CoopDistance==.
			label var CoopDistance "Kilometers from community center to Formal Cooperation"
		
		generate BankDistance1=g3b if gtype==6
			bys commid: egen BankDistance=max(BankDistance1)
			generate byte MissBankDist=BankDistance==.
			replace BankDistance=200 if BankDistance==.
			label var BankDistance "Kilometers from community center to Bank"
		
		generate BMTDistance1=g3b if gtype==7
			bys commid: egen BMTDistance=max(BMTDistance1)
			generate byte MissBMTDist=BMTDistance==.
			replace BMTDistance=200 if BMTDistance==.
			label var BMTDistance "Kilometers from community center to BMT"
		
		generate SyariahDistance1=g3b if gtype==8
			bys commid: egen SyariahDistance=max(SyariahDistance1)
			generate byte MissSyariahDist=SyariahDistance==.
			replace SyariahDistance=200 if SyariahDistance==.
			label var SyariahDistance "Kilometers from community center to Syariah/Islamic Bank"
		
		generate BRINumberOfService1=length(g3c) if gtype==1												//Generate Number of Service Provided by Bank
			bys commid: egen BRINumberOfService=max(BRINumberOfService1)
			label variable BRINumberOfService "Number of Service Provided by BRI"
		
		generate BankNumberOfService1=length(g3c) if gtype==6
			bys commid: egen BankNumberOfService=max(BankNumberOfService1)
			label variable BankNumberOfService "Number of Service Provided by Commercial Bank"

		generate SyariahNumberOfService1=length(g3c) if gtype==8
			bys commid: egen SyariahNumberOfService=max(SyariahNumberOfService1)
			label variable SyariahNumberOfService "Number of Service Provided by Syariah/Islamic Bank"

		keep if gtype==1
		
		keep commid14 *Distance *Dist *Service
save "$pathf/Data/CommunityBank2014.dta", replace

*Extract BK1_G IFLS 4 (Community Bank)
use "$ifls4c/bk1_g.dta", clear
generate BRIDistance1=g3b if gtype==1														//generate financial service distance
			bys commid: egen BRIDistance=max(BRIDistance1)
			generate byte MissBRIDist=BRIDistance==.
			replace BRIDistance=200 if BRIDistance==.
			label var BRIDistance "Kilometers from community center to Bank Rakyat Indonesia"
			
		generate BPRDistance1=g3b if gtype==2
			bys commid: egen BPRDistance=max(BPRDistance1)
			generate byte MissBPRDist=BPRDistance==.
			replace BPRDistance=200 if BPRDistance==.
			label var BPRDistance "Kilometers from community center to People Credit Bank"
		
		generate LKDDistance1=g3b if gtype==3
			bys commid: egen LKDDistance=max(LKDDistance1)
			generate byte MissLKDDist=LKDDistance==.
			replace LKDDistance=200 if LKDDistance==.
			label var LKDDistance "Kilometers from community center to Village Credit Institution"
			
		generate KUDDistance1=g3b if gtype==4
			bys commid: egen KUDDistance=max(KUDDistance1)
			generate byte MissKUDDist=KUDDistance==.
			replace KUDDistance=200 if KUDDistance==.
			label var KUDDistance "Kilometers from community center to Village Unit Cooperative"
		
		generate CoopDistance1=g3b if gtype==5
			bys commid: egen CoopDistance=max(CoopDistance1)
			generate byte MissCoopDist=CoopDistance==.
			replace CoopDistance=200 if CoopDistance==.
			label var CoopDistance "Kilometers from community center to Formal Cooperation"
		
		generate BankDistance1=g3b if gtype==6
			bys commid: egen BankDistance=max(BankDistance1)
			generate byte MissBankDist=BankDistance==.
			replace BankDistance=200 if BankDistance==.
			label var BankDistance "Kilometers from community center to Bank"
		
		generate BMTDistance1=g3b if gtype==7
			bys commid: egen BMTDistance=max(BMTDistance1)
			generate byte MissBMTDist=BMTDistance==.
			replace BMTDistance=200 if BMTDistance==.
			label var BMTDistance "Kilometers from community center to BMT"
		
		generate SyariahDistance1=g3b if gtype==8
			bys commid: egen SyariahDistance=max(SyariahDistance1)
			generate byte MissSyariahDist=SyariahDistance==.
			replace SyariahDistance=200 if SyariahDistance==.
			label var SyariahDistance "Kilometers from community center to Syariah/Islamic Bank"
		
		generate BRINumberOfService1=length(g3c) if gtype==1												//Generate Number of Service Provided by Bank
			bys commid: egen BRINumberOfService=max(BRINumberOfService1)
			label variable BRINumberOfService "Number of Service Provided by BRI"
		
		generate BankNumberOfService1=length(g3c) if gtype==6
			bys commid: egen BankNumberOfService=max(BankNumberOfService1)
			label variable BankNumberOfService "Number of Service Provided by Commercial Bank"

		generate SyariahNumberOfService1=length(g3c) if gtype==8
			bys commid: egen SyariahNumberOfService=max(SyariahNumberOfService1)
			label variable SyariahNumberOfService "Number of Service Provided by Syariah/Islamic Bank"

		keep if gtype==1
		
		keep commid07 *Distance *Dist *Service
save "$pathf/Data/CommunityBank2007.dta", replace

*Extract B3A_TK IFLS 5 (Risk-Taking Behavior)
use "$ifls5f/Book 3B/b3b_ak1.dta", clear
rename aktype BenefitType
rename ak02 BenefitTypeDummy
rename ak03 BenefitYear
rename ak04 OutpatientType
rename ak05 BenefitHHMember
rename ak01 BenefitDummy
save "$pathf/Data/HealthInsurance2014_1.dta", replace
use "$ifls5f/Book 3B/b3b_ak2.dta", clear
rename ak06 BenefitLostDummy
rename ak07 BenefitLostType
rename ak08mth BenefitLostMonth
rename ak08yr BenefitLostYear
save "$pathf/Data/HealthInsurance2014_2.dta", replace
use "$ifls5f/Book 3B/b3b_km.dta", clear
rename km01a TobaccoHabitDummy
rename km01b TobaccoChewDummy
rename km01c TobaccoPipeDummy
rename km01d TobaccoSelfrolledDummy
rename km01e TobaccoCigarettesDummy
rename km03 CigarettesType
rename km04 CigarettesQuit
rename km05aa CigarettesQuitAge
rename km06 TobaccoConsumeOunce
rename km06b TobaccoConsumePrice
rename km08 CigarettesConsume
rename km08b CigarettesConsumePack
rename km08d CigarettesConsumeTime
rename km09 CigarettesConsumeMoney
rename km10 CigarettesAgeBegin
rename km12 CigarettesRefrainDummy
rename km13 CigarettesSacrifice
save "$pathf/Data/SmokingBehavior2014.dta", replace

*Extract B3A_TK IFLS 4 (Risk-Taking Behavior)
use "$ifls4f/b3b_ak1.dta", clear
rename aktype BenefitType
rename ak02 BenefitTypeDummy
rename ak03 BenefitYear
rename ak04 OutpatientType
rename ak05 BenefitHHMember
rename ak01 BenefitDummy
collapse (first) hhid07 pid07 Benefit* OutpatientType, by(pidlink)
save "$pathf/Data/HealthInsurance2007_1.dta", replace
use "$ifls4f/b3b_ak2.dta", clear
rename ak06 BenefitLostDummy
rename ak07 BenefitLostType
rename ak08mth BenefitLostMonth
rename ak08yr BenefitLostYear
collapse (first) hhid07 pid07 Benefit*, by(pidlink)
save "$pathf/Data/HealthInsurance2007_2.dta", replace

use "$ifls4f/b3b_km.dta", clear
rename km01a TobaccoHabitDummy
rename km01b TobaccoChewDummy
rename km01c TobaccoPipeDummy
rename km01d TobaccoSelfrolledDummy
rename km01e TobaccoCigarettesDummy
rename km03 CigarettesType
rename km04 CigarettesQuit
rename km05aa CigarettesQuitAge
rename km06 TobaccoConsumeOunce
rename km06b TobaccoConsumePrice
rename km08 CigarettesConsume
rename km08b CigarettesConsumePack
rename km08d CigarettesConsumeTime
rename km09 CigarettesConsumeMoney
rename km10 CigarettesAgeBegin
save "$pathf/Data/SmokingBehavior2007.dta", replace

*Household Living Area 2014
		use "$ifls5f/Tracking Books/htrack.dta", clear
		
		bys hhid14: gen dup=cond(_N==1,0,_n)
			keep if dup<=1
		
		merge 1:1 hhid14 using "$ifls5f/Book K/bk_sc1.dta"
		keep if _merge==3
		drop _merge
		
		keep hhid14 pid14 commid14 sc01_14_14 sc02_14_14 sc03_14_14 sc05
		
		rename sc01_14_14 PrvID
		rename sc02_14_14 KabID
		rename sc03_14_14 KecID
		rename sc05 Urban
			replace Urban=0 if Urban==2
			label define Urban1 0 "0. Rural" 1 "1. Urban"
			label values Urban Urban1
	
		save "$pathf/Data/LivingArea2014.dta", replace

*Person track 2014
		use "$ifls5f/Tracking Books/ptrack.dta", clear
		
		keep pwt14xa pid14 hhid14
		
		save "$pathf/Data/PersonTrack2014.dta", replace
		
*Household Living Area 2007
		use "$ifls4f/htrack.dta", clear
		
		bys hhid07: gen dup=cond(_N==1,0,_n)
			keep if dup<=1
		
		merge 1:1 hhid07 using "$ifls4f/bk_sc.dta"
		keep if _merge==3
		drop _merge
		
		keep hhid07 pid07 commid07 sc010707 sc020707 sc030707 sc05
		
		rename sc010707 PrvID
		rename sc020707 KabID
		rename sc030707 KecID
		rename sc05 Urban
			replace Urban=0 if Urban==2
			label define Urban1 0 "0. Rural" 1 "1. Urban"
			label values Urban Urban1
	
		save "$pathf/Data/LivingArea2007.dta", replace

*Person track 2007
		use "$ifls4f/ptrack.dta", clear
		
		keep pwt07xa pid07 hhid07
		
		save "$pathf/Data/PersonTrack2007.dta", replace
