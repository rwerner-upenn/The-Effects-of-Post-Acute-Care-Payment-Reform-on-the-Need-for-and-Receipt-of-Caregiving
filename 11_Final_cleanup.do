/****************************************************************************
***Step 11: Final clean up before analysis 
****************************************************************************/
*******************************************************************************
********************************(1)Preparing Data******************************
*******************************************************************************
*Clean Medpar-OASIS merged data 
clear
cd "/project/pac_caregiving/oasis_sk_workspace/output/"
use "cohort_A_B_C_08262022.dta"


*Generate an indicator for other common DRG 
gen other_common=1 if SEPSIS_DRG==1 | UTI_DRG==1 | CHF_DRG==1 | PNEU_DRG==1 | HIPFX_DRG==1 
replace other_common=0 if TKR_THR_DRG==1

*Generate new year indicaotr based on month (one year starts from April and ends March next year)
gen year_new=.
replace year_new=2010 if ADMISSION_YEAR==2010 & ADMISSION_MONTH>=4
replace year_new=2010 if ADMISSION_YEAR==2011 & ADMISSION_MONTH<=3

replace year_new=2011 if ADMISSION_YEAR==2011 &  ADMISSION_MONTH>=4
replace year_new=2011 if ADMISSION_YEAR==2012 &  ADMISSION_MONTH<=3

replace year_new=2012 if ADMISSION_YEAR==2012 &  ADMISSION_MONTH>=4
replace year_new=2012 if ADMISSION_YEAR==2013 &  ADMISSION_MONTH<=3

replace year_new=2013 if ADMISSION_YEAR==2013 &  ADMISSION_MONTH>=4
replace year_new=2013 if ADMISSION_YEAR==2014 &  ADMISSION_MONTH<=3

replace year_new=2014 if ADMISSION_YEAR==2014 &  ADMISSION_MONTH>=4
replace year_new=2014 if ADMISSION_YEAR==2015 &  ADMISSION_MONTH<=3

replace year_new=2015 if ADMISSION_YEAR==2015 &  ADMISSION_MONTH>=4
replace year_new=2015 if ADMISSION_YEAR==2016 &  ADMISSION_MONTH<=3

replace year_new=2016 if ADMISSION_YEAR==2016 &  ADMISSION_MONTH>=4
replace year_new=2016 if ADMISSION_YEAR==2017 &  ADMISSION_MONTH<=3

replace year_new=2017 if ADMISSION_YEAR==2017 &  ADMISSION_MONTH>=4
replace year_new=2017 if ADMISSION_YEAR==2018 &  ADMISSION_MONTH<=3

replace year_new=2018 if ADMISSION_YEAR==2018 &  ADMISSION_MONTH>=4
replace year_new=2018 if ADMISSION_YEAR==2019 &  ADMISSION_MONTH<=3

*Generate post treatment year indicator 
gen post2016April=.
replace post2016April=1 if year_new==2016 | year_new==2017  | year_new==2018
replace post2016April=0 if year_new==2010 | year_new==2011  | year_new==2012 | year_new==2013 | year_new==2014 | year_new==2015

*Generate unique hospital id
egen provider_id = group(PRVDR_NUM)

*Generate indicator for hip/knee replacement 
gen hip_knee_condition=1 if TKR_THR_DRG==1
replace hip_knee_condition=0 if other_common==1

save  "cohort_A_B_C_08262022_2.dta" ,replace

* Create IADLS
gen IADL_Meal_ADM=. 
replace IADL_Meal_ADM=0 if M1880_ADM=="00"
replace IADL_Meal_ADM=1 if M1880_ADM=="01"
replace IADL_Meal_ADM=1 if M1880_ADM=="02"

gen IADL_Meal_DIS=. 
replace IADL_Meal_DIS=0 if M1880_DIS=="00"
replace IADL_Meal_DIS=1 if M1880_DIS=="01"
replace IADL_Meal_DIS=1 if M1880_DIS=="02"

gen IADL_Phone_ADM=. 
replace IADL_Phone_ADM=0 if M1890_ADM=="00"
replace IADL_Phone_ADM=0 if M1890_ADM=="01"
replace IADL_Phone_ADM=1 if M1890_ADM=="02"
replace IADL_Phone_ADM=1 if M1890_ADM=="03"
replace IADL_Phone_ADM=1 if M1890_ADM=="04"
replace IADL_Phone_ADM=1 if M1890_ADM=="05"

gen IADL_Phone_DIS=. 
replace IADL_Phone_DIS=0 if M1890_DIS=="00"
replace IADL_Phone_DIS=0 if M1890_DIS=="01"
replace IADL_Phone_DIS=1 if M1890_DIS=="02"
replace IADL_Phone_DIS=1 if M1890_DIS=="03"
replace IADL_Phone_DIS=1 if M1890_DIS=="04"
replace IADL_Phone_DIS=1 if M1890_DIS=="05"

tab IADL_Meal_ADM, missing
tab IADL_Meal_DIS, missing

tab IADL_Phone_ADM, missing
tab IADL_Phone_DIS, missing

*Create indicator for hip/knee 
tab PRCDR_CD1 if DRG_CD==469 | DRG_CD==470, sort

*Hip
gen hip_knee_category=0

global hip 8151	8152	0SR904A	0SRB04A	0SR902A	0SRB02A	0SR90JZ	0SR904Z	0SR90JA	0SRB0JZ	0SRB04Z	0SRS0JZ	0SRB0JA	0SRS0J9	0SRR0JZ	0SRR0J9	0SR902Z	0SRS0JA	0SRR0JA	0SRB02Z	0SRS01A	0SRR01A	0SRS019	0SRR019	0SR903A	0SR903Z	0SRB03A	0SRS01Z	0SR901A	0SRB03Z	0SRR01Z	0SR9029	0SRB01A	0SR90J9	0SRB029	0SRB0J9	0SR901Z	0SR9049	0SRB049	0SRB01Z	0SRR039	0SRS039	0SR906A	0SRB06A	0SR9019	0SRS03A	7865	0SR9039	0SRR03A	0SRB019	0SRB039	0SRS03Z	0SRR03Z	0SR906Z	0SRB06Z	7935	0QP704Z	0QP604Z	0SPB04Z	0SP904Z	0QS604Z	0SR9069	0QS704Z	0SRB069	7785	0SRA0JA	0SUB0BZ	0SRE0JA	0SRE0JZ	0SU90BZ	0SRA0JZ	0SR90KZ	0SRA0J9	0SRA01A	0SRB0KZ	0SRE0J9	0QS404Z	0SRE01A	0SRS0KZ	0SRA00A	7855	0QP904Z	0QPB04Z	0QSB04Z	0SRA01Z	0SRR0KZ	7765	0SRE00A	0SRE019	0SRA00Z	0SRA019	0SRE01Z	7975	0QS804Z	0SRS07Z	7915	0QB60ZZ	0SRA03A	7745	0SRA009	0SRA039	0SRE009	0SRE03A	0SUS0BZ	0QB60ZX	7925	0SR907Z	0SRR07Z	0SUR0BZ	8015	0SB90ZZ	0SRE00Z	0SWBXJZ	0S993ZX	0SRB07Z	0SRE03Z	0SUA0BZ	0SBB0ZZ	0SRA03Z	0SRA0KZ	0SS9XZZ	0SUA09Z	7905	0SSBXZZ	0SUE09Z	0SUE0BZ	0SW9XJZ	8085	8312	0SCB0ZZ	0SRA07Z	7805	0S990ZZ	0S9B0ZZ	0SC90ZZ	0SRE039	0SRE0KZ	0SSB04Z	7735	7795	7845	7985	8035	8045	8095	8140	8313	0S9B3ZX	0S9B3ZZ	0SBB0ZX	0SRE07Z	0SU909Z	0SWRXJZ	7955	7965	8826	0S993ZZ	0SB20ZZ	0SB90ZX	0SH904Z	0SJ90ZZ	0SJBXZZ	0SN90ZZ	0SN93ZZ	0SNB4ZZ	0SP9X4Z	0SPB34Z	0SPB35Z	0SPB44Z	0SQB0ZZ	0SS904Z	0SS934Z	0SS93ZZ	0ST90ZZ	0STB0ZZ	0SUB09Z	0SW909Z	0SWB04Z	0SWB09Z

foreach var in $hip {
	replace hip_knee_category=1 if PRCDR_CD1=="`var'" & TKR_THR_DRG==1
}

global knee 8154	0SRC0J9	0SRD0J9	0SRC0JZ	0SRC0JA	0SRD0JZ	0SRD0JA	0SRC069	0SRD069	0SRC0L9	0SRD0L9	0SRT0J9	0SRU0J9	0SRV0J9	0SRW0J9	0SRC06A	0SRD06Z	0SRD06A	0SRC06Z	0SRD0KZ	0SRC0KZ	0SRD0LZ	8076	0SRC0LZ	0SRT0JZ	0SRU0JZ	0SRV0JZ	0SRW0JZ	7867	7936	0SRU0JA	0SRT0JA	0SPD08Z	0SRC0LA	0SPC08Z	0SRD0LA	0SPD04Z	0SBC0ZZ	0SRD07Z	0SPC04Z	0SRV0JA	0QPG04Z	0QPH04Z	0SRW0JA	0SBD0ZZ	0SRC07Z	7866	0QP804Z	0QSC04Z	0QSG04Z	0SBD4ZZ	8147	0QBB0ZZ	0QBC0ZZ	0QS904Z	0QSH04Z	8827	8016	0SBC4ZZ	7767	0SRW0KZ	7787	8026	0SUC09C	8046	0S9D0ZZ	0SJC4ZZ	0SJD4ZZ	0SRU0KZ	0SUD09C	0SWD08Z	7786	8086	0S9C3ZZ	0S9D3ZZ	0SCC0ZZ	0SHD08Z	0SPC09Z	0SRT0KZ	7986	8144	8415	0S9C0ZZ	0S9C3ZX	0SBD0ZX	0SND0ZZ	0SPC00Z	0SRV0KZ	0SSCXZZ	0SUU09Z	7727	7747	7766	7796	7817	7856	7916	7926	7956	8143	0S9D3ZX	0SJC0ZZ	0SNCXZZ	0SNDXZZ	0SPC44Z	0SPD09Z	0SPD0KZ	0SQD4ZZ	0SRT07Z	0SRU07Z	0SRV07Z	0SSDXZZ	0STC0ZZ	0SUT09Z	0SUV09Z	0SWCXJZ	0QS504Z	0QPC04Z	0YP90YZ

foreach var in $knee {
	replace hip_knee_category=2 if PRCDR_CD1=="`var'" & TKR_THR_DRG==1
}


tab hip_knee_category if DRG_CD==469 | DRG_CD==470

gen hip_replacement=1 if hip_knee_category==1
replace hip_replacement=0 if hip_replacement==. 

gen knee_replacement=1 if hip_knee_category==2
replace knee_replacement=0 if knee_replacement==.

gen race=. 

	*White
	replace race=1 if RACEETH==1
	*Black
	replace race=2 if RACEETH==2
	*Hispanic 
	replace race=3 if RACEETH==4
	*Other and missing 
	replace race=4 if RACEETH==3 | RACEETH==5

tab race

*Replace missing dementia flag as zero
replace ALZH_DEMEN_FLAG=0 if ALZH_DEMEN_FLAG==.

*Generate indicator for short home health episode 
gen visitcnt_less_four=.
replace visitcnt_less_four=1 if VISITCNT_HHA<=4 & VISITCNT_HHA!=.
replace visitcnt_less_four=0 if VISITCNT_HHA >4 &  VISITCNT_HHA!=.

gen short_home_health=1 if VISITCNT_HHA<5 
replace short_home_health=0 if short_home_health==.
replace short_home_health=. if VISITCNT_HHA==. & RECEIVE_HOME_HEALTH==1
replace short_home_health=. if VISITCNT_HHA==0 & RECEIVE_HOME_HEALTH==1

gen visitcnt_one=1 if VISITCNT_HHA==1
replace visitcnt_one=0 if VISITCNT_HHA!=1 & VISITCNT_HHA!=.

gen visitcnt_two=1 if VISITCNT_HHA==2
replace visitcnt_two=0 if VISITCNT_HHA!=2 & VISITCNT_HHA!=.

gen visitcnt_three=1 if VISITCNT_HHA==3
replace visitcnt_three=0 if VISITCNT_HHA!=3 & VISITCNT_HHA!=.

gen visitcnt_four=1 if VISITCNT_HHA==4
replace visitcnt_three=0 if VISITCNT_HHA!=3 & VISITCNT_HHA!=.

gen visitcnt_five=1 if VISITCNT_HHA==5
replace visitcnt_five=0 if VISITCNT_HHA!=5 & VISITCNT_HHA!=.

gen visitcnt_six=1 if VISITCNT_HHA==6
replace visitcnt_six=0 if VISITCNT_HHA!=6 & VISITCNT_HHA!=.

gen visitcnt_seven=1 if VISITCNT_HHA==7
replace visitcnt_seven=0 if VISITCNT_HHA!=7 & VISITCNT_HHA!=.

missings tag M1900_AMB_YN_ADM M1900_HSH_YN_ADM M1900_SEL_YN_ADM M1900_TRN_YN_ADM M2100_ADL_NEED_ADM M2100_IADL_NEED_ADM M2100_ADL_YN_ADM M2100_IADL_YN_ADM M2100_ADL_NEED_DIS M2100_IADL_NEED_DIS M2100_ADL_YN_DIS M2100_IADL_YN_DIS M0140* if RECEIVE_HOME_HEALTH==1, generate(nmissing)

destring SEX, replace

gen female=1 if SEX==2
replace female=0 if female==.

gen white=1 if race==1
replace white=0 if white==.

gen black=1 if race==2
replace black=0 if black==.

gen hispanic=1 if race==3
replace hispanic=0 if hispanic==.

gen other=1 if race==4
replace other=0 if other==.

*create variable that indicates where the patient went after hospital discharge
*TYPE=0, home without home health  
*TYPE=1, SNF
*TYPE=2, other institution
*TYPE=3, home health 
replace TYPE=3 if RECEIVE_HOME_HEALTH==1
replace TYPE=0 if TYPE==. 
replace RECEIVE_HOME_HEALTH=0 if RECEIVE_HOME_HEALTH==.

gen went_SNF=0
replace went_SNF=1 if TYPE==1

gen went_home=0
replace went_home=1 if TYPE==0

gen oasis_race=. 

	*White
	replace oasis_race=1 if M0140_WHT_CD=="1"
	*Black
	replace oasis_race=2 if M0140_AFRCN_AMRCN_CD=="1"
	*Hispanic 
	replace oasis_race=3 if M0140_HSPNC_CD=="1"
	*Other and missing 
	replace oasis_race=4 if M0140_ASN_CD=="1" | M0140_AMRCN_INDN_AK_NTV_CD=="1" | M0140_NTV_HI_PCFC_ISLNDR_CD=="1"
	
gen referred_home_health=0
replace referred_home_health=1 if DSTNTNCD==6

save "cohort_A_B_C_08262022_3", replace 









