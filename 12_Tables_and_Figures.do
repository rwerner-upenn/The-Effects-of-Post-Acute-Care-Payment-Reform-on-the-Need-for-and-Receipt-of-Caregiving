/****************************************************************************
***Step 12: Create tables and figures 
****************************************************************************/

*Change directory and open data
cd "/project/pac_caregiving/oasis_sk_workspace/output/"
use "cohort_A_B_C_08262022_3"

*Redefine other_common
replace other_common=. if DRG_CD==480 | DRG_CD==481 | DRG_CD==482

*******************************************************************************
*For cohort A, change outcome as zero. 
*******************************************************************************
gen M1900_AMB_YN_ADM_rr=. if TKR_THR_DRG==1
replace M1900_AMB_YN_ADM_rr=M1900_AMB_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
replace M1900_AMB_YN_ADM_rr=0 if M1900_AMB_YN_ADM_rr==.

gen M1900_SEL_YN_ADM_rr=. if TKR_THR_DRG==1
replace M1900_SEL_YN_ADM_rr=M1900_SEL_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
replace M1900_SEL_YN_ADM_rr=0 if M1900_SEL_YN_ADM_rr==.

gen M1900_TRN_YN_ADM_rr=. if TKR_THR_DRG==1
replace M1900_TRN_YN_ADM_rr=M1900_TRN_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
replace M1900_TRN_YN_ADM_rr=0 if M1900_TRN_YN_ADM_rr==.

gen M1900_HSH_YN_ADM_rr=. if TKR_THR_DRG==1
replace M1900_HSH_YN_ADM_rr=M1900_HSH_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
replace M1900_HSH_YN_ADM_rr=0 if M1900_HSH_YN_ADM_rr==.

gen  M2100_ADL_NEED_ADM_rr=. if TKR_THR_DRG==1
replace  M2100_ADL_NEED_ADM_rr=M2100_ADL_NEED_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
replace  M2100_ADL_NEED_ADM_rr=0 if M2100_ADL_NEED_ADM_rr==.

gen  M2100_IADL_NEED_ADM_rr=. if TKR_THR_DRG==1
replace  M2100_IADL_NEED_ADM_rr=M2100_IADL_NEED_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
replace  M2100_IADL_NEED_ADM_rr=0 if M2100_IADL_NEED_ADM_rr==.

gen VISITCNT_HHA_rr=. if TKR_THR_DRG==1 
replace VISITCNT_HHA_rr=VISITCNT_HHA if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 & VISITCNT_HHA>0 & VISITCNT_HHA!=.
replace VISITCNT_HHA_rr=0 if VISITCNT_HHA_rr==.

gen short_home_health_rr=. if TKR_THR_DRG==1 
replace short_home_health_rr=short_home_health if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 
replace short_home_health_rr=0 if short_home_health_rr==.

gen M2100_ADL_NEED_DIS_rr=. if TKR_THR_DRG==1 
replace M2100_ADL_NEED_DIS_rr=M2100_ADL_NEED_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 
replace M2100_ADL_NEED_DIS_rr=0 if M2100_ADL_NEED_DIS_rr==.

gen M2100_IADL_NEED_DIS_rr=. if TKR_THR_DRG==1 
replace M2100_IADL_NEED_DIS_rr=M2100_IADL_NEED_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 
replace M2100_IADL_NEED_DIS_rr=0 if M2100_IADL_NEED_DIS_rr==.

gen M2100_ADL_YN_DIS_rr=. if TKR_THR_DRG==1 
replace M2100_ADL_YN_DIS_rr=M2100_ADL_YN_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 
replace M2100_ADL_YN_DIS_rr=0 if M2100_ADL_YN_DIS_rr==.

gen M2100_IADL_YN_DIS_rr=. if TKR_THR_DRG==1 
replace M2100_IADL_YN_DIS_rr=M2100_IADL_YN_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 
replace M2100_IADL_YN_DIS_rr=0 if M2100_IADL_YN_DIS_rr==.


*******************************************************************************
*Table 1 Cohort A 
*******************************************************************************

*No. of observations 
unique OBS_ID if TKR_THR_DRG==1
*Age 
tabstat AGE_ADM if TKR_THR_DRG==1, stat(mean sd)
*Female
tab SEX if TKR_THR_DRG==1
*Race
tab race if TKR_THR_DRG==1
*Dual eligible 
tab DUAL_ELIGIBLE if TKR_THR_DRG==1
*Elixhauser comorbidities 
tabstat INDEX_TOT_GRP if TKR_THR_DRG==1, stat(mean sd)
*Cognitive impairment/dementia
tab ALZH_DEMEN_FLAG if TKR_THR_DRG==1
*Number of days in the hospital 
tabstat  LOS_MEDPAR if TKR_THR_DRG==1, stat(mean sd)
*Hospitalization for hip replacement / knee replacement 
tab hip_knee_category if TKR_THR_DRG==1
*Ambulation
tab M1900_AMB_YN_ADM_rr if TKR_THR_DRG==1 
*Self-care
tab M1900_SEL_YN_ADM_rr if TKR_THR_DRG==1 
*Transfer
tab M1900_TRN_YN_ADM_rr if TKR_THR_DRG==1 
*Household task
tab M1900_HSH_YN_ADM_rr if TKR_THR_DRG==1 
*Received home health/went to SNF/went home without home health at hospital discharge 
tab TYPE if TKR_THR_DRG==1
*Needs help with ADLs at discharge from hospital 
tab M2100_ADL_NEED_ADM_rr if TKR_THR_DRG==1 
*Needs help with IADLs at discharge from hospital 
tab M2100_IADL_NEED_ADM_rr if TKR_THR_DRG==1 
*# of home health visit
tabstat VISITCNT_HHA_rr if TKR_THR_DRG==1, stat(mean sd)
*Had short home heealth episode 
tab short_home_health_rr if TKR_THR_DRG==1 
*Needs help with ADLs at discharge from home health
tab M2100_ADL_NEED_DIS_rr if TKR_THR_DRG==1
*Needs help with IADLs at discharge from home health
tab M2100_IADL_NEED_DIS_rr if TKR_THR_DRG==1 
*Receives caregiving for help with ADLs at discharge from home health
tab M2100_ADL_YN_DIS_rr if TKR_THR_DRG==1 
*Receives caregiving for help with IADLs at discharge from home health
tab M2100_IADL_YN_DIS_rr if TKR_THR_DRG==1 

*******************************************************************************
*Table 1 Cohort B 
*******************************************************************************
*No. of observations 
unique OBS_ID_DIS if TKR_THR_DRG==1 & nmissing==0
*Age 
tabstat AGE_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, stat(mean sd)
*Female
tab SEX if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Race
tab race if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Dual eligible 
tab DUAL_ELIGIBLE if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Elixhauser comorbidities 
tabstat INDEX_TOT_GRP if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, stat(mean sd)
*Cognitive impairment/dementia
tab ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Number of days in the hospital 
tabstat  LOS_MEDPAR if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, stat(mean sd)
*Hospitalization for hip replacement / knee replacement 
tab hip_knee_category if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Ambulation
tab M1900_AMB_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Self-care
tab M1900_SEL_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Transfer
tab M1900_TRN_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Household task
tab M1900_HSH_YN_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Needs help with ADLs at discharge from hospital 
tab M2100_ADL_NEED_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Needs help with IADLs at discharge from hospital 
tab M2100_IADL_NEED_ADM if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*# of home health visits 
tabstat VISITCNT_HHA if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 & VISITCNT_HHA>0 & VISITCNT_HHA!=., stat(mean sd n)
*Had short home health episode 
tab short_home_health if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0 
*Needs help with ADLs at discharge from home health
tab M2100_ADL_NEED_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Needs help with IADLs at discharge from home health
tab M2100_IADL_NEED_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Receives caregiving for help with ADLs at discharge from home health
tab M2100_ADL_YN_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0
*Receives caregiving for help with IADLs at discharge from home health
tab M2100_IADL_YN_DIS if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0

*******************************************************************************
*Table 1 Cohort C 
*******************************************************************************
*No. of observations 
unique OBS_ID_DIS if other_common==1 & nmissing==0
*Age 
tabstat AGE_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0, stat(mean sd)
*Female
tab SEX if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Race
tab race if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Dual eligible 
tab DUAL_ELIGIBLE if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Elixhauser comorbidities 
tabstat INDEX_TOT_GRP if other_common==1 & OBS_ID_DIS!=. & nmissing==0, stat(mean sd)
*Cognitive impairment/dementia
tab ALZH_DEMEN_FLAG if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Number of days in the hospital 
tabstat  LOS_MEDPAR if other_common==1 & OBS_ID_DIS!=. & nmissing==0, stat(mean sd)
*Ambulation
tab M1900_AMB_YN_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Self-care
tab M1900_SEL_YN_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Transfer
tab M1900_TRN_YN_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Household task
tab M1900_HSH_YN_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Needs help with ADLs at discharge from hospital 
tab M2100_ADL_NEED_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Needs help with IADLs at discharge from hospital 
tab M2100_IADL_NEED_ADM if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*# of home health visits 
tabstat VISITCNT_HHA if other_common==1 & OBS_ID_DIS!=. & nmissing==0 & VISITCNT_HHA>0 & VISITCNT_HHA!=., stat(mean sd n)
*Had short home health episode 
tab short_home_health if other_common==1 & OBS_ID_DIS!=. & nmissing==0 
*Needs help with ADLs at discharge from home health
tab M2100_ADL_NEED_DIS if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Needs help with IADLs at discharge from home health
tab M2100_IADL_NEED_DIS if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Receives caregiving for help with ADLs at discharge from home health
tab M2100_ADL_YN_DIS if other_common==1 & OBS_ID_DIS!=. & nmissing==0
*Receives caregiving for help with IADLs at discharge from home health
tab M2100_IADL_YN_DIS if other_common==1 & OBS_ID_DIS!=. & nmissing==0

*******************************************************************************
*Figure 1. Event study graph of changes in home health utilization, SNF admission 
*for cohort undergoing knee or hip replacement in CJR-participating vs. 
*non-CJR-participating markets (Cohort A)
*******************************************************************************

*Set panel, there are repeated time within a provider_id since the data is at the discharge level so we only set the identifier variable and not the time variable. 
xtset provider_id 

*Generate variable that indicates time to treatment
gen treattime=.
replace treattime=2016 if CJR_PARTICIPANT==1

gen time_to_treat=year_new-treattime

tab time_to_treat,
tab CJR_PARTICIPANT if time_to_treat!=.

*Went SNF 
eventdd went_SNF i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Admitted to a SNF", size(huge)) ytitle("Admitted to a SNF (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.06(0.02)0.06, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white))legend(off))

*Received home health 
replace RECEIVE_HOME_HEALTH=0 if RECEIVE_HOME_HEALTH==.
eventdd RECEIVE_HOME_HEALTH i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Home with Home Health", size(huge)) ytitle("Home with Home Health (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge))  ylabel(-0.06(0.02)0.06, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white))legend(off))

*Went home 
eventdd went_home i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Home without Home Health", size(huge)) ytitle("Home without Home Health (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.06(0.02)0.06, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white))legend(off))

*******************************************************************************
*Table 2. Two-way fixed effects difference-in-differences estimates of changes in 
*patient characteristics and hospital discharge destination for cohort undergoing 
*knee or hip replacement in CJR-participating vs. non-CJR-participating markets 
*(Cohort A) 
*******************************************************************************

*Went to SNF at hospital discharge
xtreg went_SNF i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)

*Received home health at hospital discharge 
replace RECEIVE_HOME_HEALTH=0 if RECEIVE_HOME_HEALTH==.
xtreg RECEIVE_HOME_HEALTH i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)

*Went home without home health at discahrge 
xtreg went_home i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)

*******************************************************************************
*Figure 2. Event study graphs of changes in intensity of home health episodes, 
*for cohort undergoing knee or hip replacement in CJR-participating vs. 
*non-CJR-participating markets (Cohort A)
*******************************************************************************
*Episodies < 5 visits 
eventdd short_home_health_rr AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Episodes < 5 Visits", size(vlarge)) xtitle("Year", size(medlarge)) ytitle(" Had Short Home Health Episode (%)", size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Average # of Visits 
xtpoisson VISITCNT_HHA_rr i.year_new i.b2015.year_new##i.CJR_PARTICIPANT AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1, fe vce(robust)

estimates store VISITCNT_HHA_rr_event

coefplot VISITCNT_HHA_rr_event, keep(*.year_new#1.CJR_PARTICIPANT) vertical mlabel format(%9.2f) mcolor(maroon) title("Average Number of Visits", size(vlarge)) ytitle("Coefficients", size(medlarge)) xtitle("Year", size(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) xline (5.5) yline(0) ciopts(recast(rcap)) legend(off)

*******************************************************************************
*Table 3. Two-way fixed effects estimates of changes in intensity of the home 
*health episodes. Estimates are based on the cohort undergoing knee or 
*hip replacement and receiving home health at hospital discharge in 
*CJR-participating vs. non-CJR-participating markets (Cohort B) and 
*compared to cohort hospitalized for other conditions (Cohort C).
*******************************************************************************
*******************************************************************************
*D-in-D Cohort A
*******************************************************************************
*Had short home health episode (<5 visits)
xtreg short_home_health_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1, fe cluster(provider_id)
	
*Average # of visits 
xtpoisson VISITCNT_HHA_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1, fe vce(robust)

*******************************************************************************
*D-in-D Cohort B
*******************************************************************************
*Had short home health episode (<5 visits)
xtreg short_home_health i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0 , fe cluster(provider_id)
	
*Average # of visits  
xtpoisson VISITCNT_HHA i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0 & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)

*******************************************************************************
*D-in-D-in-D
*******************************************************************************
*Had short home health episode (<5 visits)
xtreg short_home_health i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if other_common!=. & OBS_ID_DIS!=. & nmissing==0 , fe cluster(provider_id)

*Average # of visits 
xtpoisson VISITCNT_HHA i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0 & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)

*******************************************************************************
*Figure 3. Event study graphs of changes in patients' need for help and receipt 
*of help from caregiver for ADLs and IADLs at discharge from home health, for 
*cohort undergoing knee or hip replacement and receiving home health at hospital 
*discharge in CJR-participating vs. non-CJR-participating markets (Cohort A)
*******************************************************************************
*Need Help with ADLs at Home Health D/C
eventdd M2100_ADL_NEED_DIS_rr AGE_ADM i.female i.race  i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1 , fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Need Help with ADLs at Home Health D/C", size(vlarge)) xtitle("Year",size(medlarge)) ytitle("Need Help with ADLs at Home Health D/C (%)", size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) ylabel(-0.02(0.02)0.06, labsize(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Need Help with IADLs at Home Health D/C
eventdd M2100_IADL_NEED_DIS_rr AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1 , fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Need Help with IADLs at Home Health D/C", size(vlarge)) xtitle("Year", size(medlarge)) ytitle("Need Help with IADLs at Home Health D/C (%)", size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) ylabel(-0.02(0.02)0.06, labsize(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Receive Help with ADLs at Home Health D/C
eventdd M2100_ADL_YN_DIS_rr AGE_ADM i.female i.race  i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Receiving Help with ADLs at Home Health D/C", size(vlarge)) xtitle("Year",size(medlarge)) ytitle("Receiving Help with ADLs at Home Health D/C (%)",size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) ylabel(-0.02(0.02)0.06, labsize(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Receive Help with IADLs at Home Health D/C
gen  M2100_IADL_YN_DIS_rr=. if TKR_THR_DRG==1
replace  M2100_IADL_YN_DIS_rr= M2100_IADL_YN_DIS if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0
replace  M2100_IADL_YN_DIS_rr=0 if M2100_IADL_YN_DIS_rr==.

eventdd M2100_IADL_YN_DIS_rr AGE_ADM i.female i.race  i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1  , fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Receiving Help with IADLs at Home Health D/C", size(vlarge)) xtitle("Year", size(medlarge)) ytitle("Receiving Help with IADLs at Home Health D/C", size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) ylabel(-0.02(0.02)0.06, labsize(medlarge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*******************************************************************************
*Table 4. Two-way fixed effects estimates of changes in need for and receipt of help 
*with ADLs and IADLs at home health discharge. Main estimates are based on the cohort 
*undergoing knee or hip replacement (Cohort A). Specification checks are based on the 
*cohort undergoing knee or hip replacement and receiving home health at hospital 
*discharge in CJR-participating vs. non-CJR-participating markets (Cohort B) and 
*compared to cohort hospitalized for other conditions (Cohort C).
*******************************************************************************

*******************************************************************************
*D-in-D Cohort A
*******************************************************************************
*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 , fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 , fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 , fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement   i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 , fe cluster(provider_id)

*******************************************************************************
*D-in-D Cohort B
*******************************************************************************
*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement   i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*******************************************************************************
*D-in-D-in-D Cohort B and C
*******************************************************************************

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race  i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=. & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)	

*******************************************************************************
*Figure 4. Event study graphs of changes in patient characteristics for cohort 
*undergoing knee or hip replacement in CJR-participating vs. non-CJR-participating 
*markets (Cohort A)
*******************************************************************************

*Age 
eventdd AGE_ADM  i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op( title("Age", size(huge)) ytitle("Age (years)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.2(0.1)0.3, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off)) 

*Female 
eventdd female i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op( title("Female", size(huge)) ytitle("Female (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Black 
eventdd black i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op( title("Black", size(huge)) ytitle("Black (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*White 
eventdd white i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("White", size(huge)) ytitle("White (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Hispanic 
eventdd hispanic i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Hispanic", size(huge)) ytitle("Hispanic (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Other Race 
eventdd other i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Other Race", size(huge)) ytitle("Other Race (%)", size(vlarge)) xtitle("Year", size(vlarge))  xlabel(-6(1)2, labsize(vlarge))  ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Dual eligible 
eventdd DUAL_ELIGIBLE i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Dual Eligible", size(huge)) ytitle("Dual Eligible (%)", size(vlarge))  xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*#Elixhauser comorbidities
eventdd INDEX_TOT_GRP i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Elixhauser Comorbidities", size(huge)) ytitle("Elixhauser Comorbidities (count)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.2(0.1)0.3, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Cognitive impairment/dementia
eventdd ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Cognitive Impairment", size(huge)) ytitle("Cognitive Impairment (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge))  ylabel(-0.01(0.01)0.03, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Hospital length of stay 
eventdd LOS_MEDPAR i.year_new i.knee_replacement if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Hospital Length of Stay", size(huge)) ytitle("Hospital Length of Stay (days)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.2(0.1)0.3, labsize(vlarge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Knee Replacement 
eventdd knee_replacement i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Knee Replacement", size(huge)) ytitle("Knee Replacement (%)", size(vlarge)) xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.04(0.02)0.04, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Hip replacement 
eventdd hip_replacement i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op( title("Hip Replacement", size(huge)) ytitle("Hip Replacement (%)", size(vlarge))  xtitle("Year", size(vlarge)) xlabel(-6(1)2, labsize(vlarge)) ylabel(-0.04(0.02)0.04, labsize(vlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*******************************************************************************
*Table 5. Two-way fixed effects difference-in-differences estimates of changes in 
*patient characteristics for cohort undergoing knee or hip replacement in 
*CJR-participating vs. non-CJR-participating markets (Cohort A) and cohort 
*receiving home health after hospital discharge (Cohort B)
*******************************************************************************

*******************************************************************************
*Cohort A 
*******************************************************************************
*Age
xtreg AGE_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Female
xtreg female i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*White
xtreg white i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Black
xtreg black i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Hispanic
xtreg hispanic i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Other 
xtreg other i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Dual eligible 
xtreg DUAL_ELIGIBLE i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*#Elixhauser comorbidities
xtreg INDEX_TOT_GRP i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Cognitive impairment/dementia 
xtreg ALZH_DEMEN_FLAG i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*# of days in the hospital
xtreg LOS_MEDPAR i.knee_replacement i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Hospitalization for knee replacement 
xtreg knee_replacement i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)
*Hospitalization for hip replacement 
xtreg hip_replacement i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1, fe cluster(provider_id)


*******************************************************************************
*Cohort B
******************************************************************************
*Age
xtreg AGE_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Female
xtreg female i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*White
xtreg white i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Black
xtreg black i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Hispanic
xtreg hispanic i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Other 
xtreg other i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Dual eligible 
xtreg DUAL_ELIGIBLE i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*#Elixhauser comorbidities
xtreg INDEX_TOT_GRP i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Cognitive impairment/dementia 
xtreg ALZH_DEMEN_FLAG i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*# of days in the hospital
xtreg LOS_MEDPAR i.year_new i.CJR_PARTICIPANT##i.post2016April i.knee_replacement if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Hospitalization for knee replacement 
xtreg knee_replacement i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Hospitalization for hip replacement 
xtreg hip_replacement i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Ambulation
xtreg M1900_AMB_YN_ADM  i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Household Task 
xtreg M1900_HSH_YN_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Transfer 
xtreg M1900_TRN_YN_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
*Self-care
xtreg M1900_SEL_YN_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)


*******************************************************************************
*Figure 5. Event study graphs of changes in patient characteristics and their hospitalization 
*for cohort undergoing knee or hip replacement and receiving home health at hospital 
*discharge in CJR-participating vs. non-CJR-participating markets (Cohort B)
*******************************************************************************
*Age 
eventdd AGE_ADM  i.year_new if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Age", size(vhuge)) xtitle("Year", size(huge)) ytitle("Age (years)", size(huge)) xlabel(-6(1)2, labsize(huge))  ylabel(-0.2(0.1)0.3, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Female 
eventdd female i.year_new if TKR_THR_DRG==1 & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Female", size(vhuge)) xtitle("Year", size(huge)) ytitle("Female (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.01(0.01)0.03, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Black 
eventdd black i.year_new if  TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Black", size(vhuge)) xtitle("Year", size(huge)) ytitle("Black (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.01(0.01)0.03, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*White 
eventdd white i.year_new if  TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("White", size(vhuge)) xtitle("Year", size(huge)) ytitle("White (%)", size(huge)) xlabel(-6(1)2, labsize(huge))  ylabel(-0.01(0.01)0.03, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Hispanic 
eventdd hispanic i.year_new if  TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Hispanic", size(vhuge)) xtitle("Year", size(huge)) ytitle("Hispanic (%)", size(huge)) xlabel(-6(1)2, labsize(huge))  ylabel(-0.01(0.01)0.03, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Other Race 
eventdd other i.year_new  if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0,fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Other Race", size(vhuge)) xtitle("Year", size(huge)) ytitle("Other Race (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.01(0.01)0.03, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Dual eligible 
eventdd DUAL_ELIGIBLE i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Dual Eligible", size(vhuge)) xtitle("Year", size(huge)) ytitle("Dual Eligible (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.01(0.01)0.03, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*#Elixhauser comorbidities
eventdd INDEX_TOT_GRP i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0,  fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Elixhauser Comorbidities", size(vhuge)) xtitle("Year", size(huge)) ytitle("Elixhauser Comorbidities (count)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.2(0.1)0.3, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Cognitive impairment/dementia
eventdd ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Cognitive Impairment", size(vhuge)) xtitle("Year", size(huge)) ytitle("Cognitive Impairment (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.01(0.01)0.03, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Hospital length of stay 
eventdd LOS_MEDPAR i.year_new i.knee_replacement if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0,  fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Hospital Length of Stay", size(vhuge)) xtitle("Year", size(huge)) ytitle("Hospital Length of Stay (days)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.2(0.1)0.3, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Knee Replacement 
eventdd knee_replacement i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op( title("Knee Replacement", size(vhuge)) xtitle("Year", size(huge)) ytitle("Knee Replacement (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.04(0.02)0.04, labsize(huge))   plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Hip replacement 
eventdd hip_replacement i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Hip Replacement", size(vhuge)) xtitle("Year", size(huge)) ytitle("Hip Replacement (%)", size(huge)) xlabel(-6(1)2, labsize(huge))  ylabel(-0.04(0.02)0.04, labsize(huge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Ambulation
eventdd M1900_AMB_YN_ADM i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Ambulation prior to Hosp.", size(vhuge)) xtitle("Year", size(huge)) ytitle("Dependence (%)",size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.04(0.02)0.02, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Self-care
eventdd M1900_SEL_YN_ADM i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Self-care prior to Hosp.", size(vhuge)) xtitle("Year", size(huge)) ytitle("Dependence (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.04(0.02)0.02, labsize(huge))   plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Transfer 
eventdd M1900_TRN_YN_ADM i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Transfer prior to Hosp.", size(vhuge)) xtitle("Year", size(huge)) ytitle("Dependence (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.04(0.02)0.02, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Household Tasks
eventdd M1900_HSH_YN_ADM i.year_new if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Household Tasks prior to Hosp.", size(vhuge)) xtitle("Year", size(huge)) ytitle("Dependence (%)", size(huge)) xlabel(-6(1)2, labsize(huge)) ylabel(-0.04(0.02)0.02, labsize(huge))  plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*******************************************************************************
*Figure 6. Event study graphs of changes in patients' need for help from caregiver 
*for ADLs and IADLs at discharge from the hospital, for cohort undergoing knee or 
*hip replacement and receiving home health at hospital discharge in CJR-participating 
*vs. non-CJR-participating markets (Cohort A)
*******************************************************************************

*Set panel, there are repeated time within a provider_id since the data is at the discharge level so we only set the identifier variable and not the time variable. 
xtset provider_id 

*Generate variable that indicates time to treatment
gen treattime=.
replace treattime=2016 if CJR_PARTICIPANT==1

gen time_to_treat=year_new-treattime

tab time_to_treat
tab CJR_PARTICIPANT if time_to_treat!=.

*Need Help with ADLs at Hospital D/C
eventdd M2100_ADL_NEED_ADM_rr AGE_ADM i.female i.race  i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Need Help with ADLs at Hospital D/C", size(vlarge)) xtitle("Year",size(medlarge)) ytitle("Need Help with ADLs at Hospital D/C (%)", size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) ylabel(-0.02(0.02)0.06, labsize(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*Need Help with IADLs at Hospital D/C
eventdd M2100_IADL_NEED_ADM_rr AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG i.year_new if TKR_THR_DRG==1, fe timevar(time_to_treat) ci(rcap) cluster(provider_id) graph_op(title("Need Help with IADLs at Hospital D/C", size(vlarge)) xtitle("Year", size(medlarge)) ytitle("Need Help with IADLs at Hospital D/C (%)", size(medlarge)) xlabel(-6(1)2, labsize(medlarge)) ylabel(-0.02(0.02)0.06, labsize(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) legend(off))

*******************************************************************************
*Table 6. Two-way fixed effects estimates of changes in need for help with ADLs and 
*IADLs at hospital discharge. Main estimates are based on the cohort undergoing 
*knee or hip replacement (Cohort A). Specification checks are based on the cohort 
*undergoing knee or hip replacement and receiving home health at hospital discharge 
*in CJR-participating vs. non-CJR-participating markets (Cohort B) and compared to 
*cohort hospitalized for other conditions (Cohort C).
*******************************************************************************

*******************************************************************************
*D in D Cohort B
*******************************************************************************
*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*******************************************************************************
*D-in-D-in-D Cohort B and C
*******************************************************************************
*Needs help with ADLs at discharge from hospitalization

xtreg M2100_ADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race  i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*******************************************************************************
*Appendix Figure 1. The average amount Medicare paid for home health episodes, 
*based on the number of home health visits made during that episode.
*******************************************************************************
*******************************************************************************
*Appendix Figure 2. The distribution of the number of home health visits in a 
*home health episode (as a percent of all home health episodes), comparing before 
*and after CJR was implemented in markets with and without CJR, as well as comparing 
*CJR to non-CJR markets before CJR was implemented.
*******************************************************************************
*We used Excel to create the above two Figures. 

*******************************************************************************
*Appendix Figure 3. Event study graph of changes in number of home health episodes, 
*for cohort undergoing knee or hip replacement and receiving home health at hospital 
*discharge in CJR-participating vs. non-CJR-participating markets, compared to those 
*hospitalized for other conditions, using difference-in-difference-in-differences framework.
*******************************************************************************
*Average # of Visits 
xtpoisson VISITCNT_HHA i.year_new i.b2015.year_new##i.CJR_PARTICIPANT##i.hip_knee_condition AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0 & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)

estimates store VISITCNT_HHA_event_ddd

coefplot VISITCNT_HHA_event_ddd, keep(*.year_new#1.CJR_PARTICIPANT#1.hip_knee_condition) vertical mlabel format(%9.2f) mcolor(maroon) title("Average Number of Visits", size(vlarge)) ytitle("Coefficients", size(medlarge)) xtitle("Year", size(medlarge)) plotregion(fcolor(white)) graphregion(fcolor(white)) xline(5.5) yline(0) ciopts(recast(rcap)) legend(off)

*******************************************************************************
*Appendix Table 1. Two-way fixed effects estimates of changes in (a) intensity of home 
*health episodes, (b) need for help with ADLs and IADLs at discharge from the hospital 
*for cohort undergoing knee or hip replacement, and (c) need for and receiving help at 
*discharge from home health in CJR-participating vs. non-CJR-participating markets 
*(Cohort B) and compared to cohort hospitalized for other conditions (Cohort C), stratified by knee or hip replacement. 
*******************************************************************************

*******************************************************************************
*Cohort A
*******************************************************************************
*******************************************************************************
*D-in-D Knee 
*******************************************************************************

*Had short home health episode (<5 visits)
xtreg short_home_health_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)
	
*Average # of visits 
xtpoisson VISITCNT_HHA_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe vce(robust)
	
*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1, fe cluster(provider_id)

*******************************************************************************
*Cohort A
*******************************************************************************
*******************************************************************************
*D-in-D Hip
*******************************************************************************

*Had short home health episode (<5 visits)
xtreg short_home_health_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)
	
*Average # of visits 
xtpoisson VISITCNT_HHA_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe vce(robust)
	
*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1, fe cluster(provider_id)

*******************************************************************************
*Cohort B 
*******************************************************************************

*******************************************************************************
*D-in-D Knee 
*******************************************************************************

*Had short home health episode (<5 visits)
xtreg short_home_health i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1  & OBS_ID_DIS!=. & nmissing==0 , fe cluster(provider_id)
	
*Average # of visits 
xtpoisson VISITCNT_HHA i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)
	
*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)


*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)


*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & knee_replacement==1 & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

	
	
*******************************************************************************
*D-in-D Hip
*******************************************************************************
*Had short home health episode (<5 visits)
xtreg short_home_health i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0 , fe cluster(provider_id)
	
*Average # of visits 
xtpoisson VISITCNT_HHA i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)

*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe cluster(provider_id)

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe cluster(provider_id)

*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe cluster(provider_id)

	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & hip_replacement==1 & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe cluster(provider_id)

*******************************************************************************
*D-in-D-in-D Knee 
*******************************************************************************

*Had short home health episode (<5 visits)
xtreg short_home_health i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if (other_common==1 | knee_replacement==1) & OBS_ID_DIS!=. & nmissing==0 , fe cluster(provider_id)

*Average # of visits 
xtpoisson VISITCNT_HHA i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1) & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)

*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1)  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1) & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1) & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1) & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1)  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | knee_replacement==1)   & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	

*******************************************************************************
*D-in-D-in-D Hip
*******************************************************************************
*Had short home health episode (<5 visits)

xtreg short_home_health i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG  if (other_common==1 | hip_replacement==1) & OBS_ID_DIS!=. & nmissing==0 , fe cluster(provider_id)

*Average # of visits 
xtpoisson VISITCNT_HHA i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1) & OBS_ID_DIS!=. & nmissing==0  & VISITCNT_HHA>0 & VISITCNT_HHA!=., fe vce(robust)
	
*Needs help with ADLs at discharge from hospitalization
xtreg M2100_ADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1)  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from hospital 
xtreg M2100_IADL_NEED_ADM i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1) & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1) & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1) & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1)  & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if (other_common==1 | hip_replacement==1)   & OBS_ID_DIS!=. & nmissing==0, fe cluster(provider_id)

*******************************************************************************
*Appendix Table 2. Replication of Table 4 excluding 8 MSAs that dropped out after 
*randomization. Two-way fixed effects estimates of changes in need for and receipt 
*of help with ADLs and IADLs at home health discharge. Estimates are based on the 
*cohort undergoing knee or hip replacement and receiving home health at hospital 
*discharge in CJR-participating vs. non-CJR-participating markets (Cohort B) and 
*compared to cohort hospitalized for other conditions (Cohort C) after excluding 
*the 8 MSAs that dropped out of CJR after randomization.
*******************************************************************************

gen exclude_MSA=.
*Colorado Springs, CO
replace exclude_MSA=1 if MSA==17820 
*Evansville, IN-KY
replace exclude_MSA=1 if MSA==21780
*Fort Collins, CO
replace exclude_MSA=1 if MSA==22660 
*Las Vegas-Henderson-Paradise, NV
replace exclude_MSA=1 if MSA==29820
*Medford, OR
replace exclude_MSA=1 if MSA==32780
*Richmond, VA
replace exclude_MSA=1 if MSA==40060
*Rockford, IL
replace exclude_MSA=1 if MSA==40420
*Virginia Beach-Norfolk-Newport News, VA-NC
replace exclude_MSA=1 if MSA==47260

*******************************************************************************
*D in D Cohort A
*******************************************************************************

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & exclude_MSA!=1, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & exclude_MSA!=1, fe cluster(provider_id)

*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & exclude_MSA!=1, fe cluster(provider_id)

*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS_rr i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1 & exclude_MSA!=1, fe cluster(provider_id)

*******************************************************************************
*D-in-D Cohort B
*******************************************************************************

*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April AGE_ADM i.female i.race i.knee_replacement   i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if TKR_THR_DRG==1  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)

*******************************************************************************
*D-in-D-in-D Cohort B and Cohort C 
*******************************************************************************
	
*Needs help with ADLs at discharge from home health
xtreg M2100_ADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race  i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=. & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)

*Needs help with IADLs at discharge from home health
xtreg M2100_IADL_NEED_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)
	
*Receives caregiving for help with ADLs at discharge from home health
xtreg M2100_ADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)
	
*Receives caregiving for help with IADLs at discharge from home health
xtreg M2100_IADL_YN_DIS i.year_new i.CJR_PARTICIPANT##i.post2016April##i.hip_knee_condition  AGE_ADM i.female i.race i.knee_replacement  i.DUAL_ELIGIBLE LOS_MEDPAR i.INDEX_ELX_GRP_1 i.INDEX_ELX_GRP_2 i.INDEX_ELX_GRP_3 i.INDEX_ELX_GRP_4 i.INDEX_ELX_GRP_5 i.INDEX_ELX_GRP_6 i.INDEX_ELX_GRP_7 i.INDEX_ELX_GRP_8 i.INDEX_ELX_GRP_9 i.INDEX_ELX_GRP_10 i.INDEX_ELX_GRP_11 i.INDEX_ELX_GRP_12 i.INDEX_ELX_GRP_13 i.INDEX_ELX_GRP_14 i.INDEX_ELX_GRP_15 i.INDEX_ELX_GRP_16 i.INDEX_ELX_GRP_17 i.INDEX_ELX_GRP_18 i.INDEX_ELX_GRP_19 i.INDEX_ELX_GRP_20 i.INDEX_ELX_GRP_21 i.INDEX_ELX_GRP_22 i.INDEX_ELX_GRP_23 i.INDEX_ELX_GRP_24 i.INDEX_ELX_GRP_25 i.INDEX_ELX_GRP_26 i.INDEX_ELX_GRP_27 i.INDEX_ELX_GRP_28 i.INDEX_ELX_GRP_29 i.INDEX_ELX_GRP_30 i.INDEX_ELX_GRP_31 i.ALZH_DEMEN_FLAG if other_common!=.  & OBS_ID_DIS!=. & nmissing==0 & exclude_MSA!=1, fe cluster(provider_id)















