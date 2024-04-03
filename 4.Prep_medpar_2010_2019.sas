/****************************************************************************
***Step 4: Clean up MedPAR and Denom 
****************************************************************************/

/*******************************************************************************
***Read data from Denominator data 2010-2019
*******************************************************************************/
data sktemp.Denominator2010_2019;
	set Denom.Dn100mod_2010 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2011 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2012 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2013 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2014 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2015 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2016 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2017 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2018 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		Denom.Dn100mod_2019 (keep = BENE_ID BENE_DOB DEATH_DT RFRNC_YR SEX RACE HMOIND: BUYIN: DUAL:)
		;
	rename  
			BUYIN01=BUYIN1 BUYIN02=BUYIN2 BUYIN03=BUYIN3 BUYIN04=BUYIN4 
			BUYIN05=BUYIN5 BUYIN06=BUYIN6 BUYIN07=BUYIN7 BUYIN08=BUYIN8 
			BUYIN09=BUYIN9 
			HMOIND01=HMOIND1 HMOIND02=HMOIND2 HMOIND03=HMOIND3 HMOIND04=HMOIND4
			HMOIND05=HMOIND5 HMOIND06=HMOIND6 HMOIND07=HMOIND7 HMOIND08=HMOIND8 
			HMOIND09=HMOIND9
			DUAL_STUS_CD_01 = DUAL_STUS_CD_1
			DUAL_STUS_CD_02 = DUAL_STUS_CD_2
			DUAL_STUS_CD_03 = DUAL_STUS_CD_3
			DUAL_STUS_CD_04 = DUAL_STUS_CD_4
			DUAL_STUS_CD_05 = DUAL_STUS_CD_5
			DUAL_STUS_CD_06 = DUAL_STUS_CD_6
			DUAL_STUS_CD_07 = DUAL_STUS_CD_7
			DUAL_STUS_CD_08 = DUAL_STUS_CD_8
			DUAL_STUS_CD_09 = DUAL_STUS_CD_9			
			;	         
run;

*Add years to variable names

%macro denom(year, yr, start, end);

data sktemp.Dn100mod_&year.;
	set sktemp.Denominator2010_2019; 
	if RFRNC_YR = &year.; 
	rename	
			DEATH_DT = DEATH_DT_&yr.
			BUYIN1-BUYIN12 = BUYIN&start.-BUYIN&end.
			HMOIND1-HMOIND12 = HMOIND&start.-HMOIND&end.
			DUAL_STUS_CD_1-DUAL_STUS_CD_12 = DUAL&start.-DUAL&end.
			;
run;

proc sort data = sktemp.Dn100mod_&year.; by BENE_ID; run;

%mend denom;
%denom(2010, 10, 1, 12)
%denom(2011, 11, 13, 24)
%denom(2012, 12, 25, 36)
%denom(2013, 13, 37, 48)
%denom(2014, 14, 49, 60)
%denom(2015, 15, 61, 72)
%denom(2016, 16, 73, 84)
%denom(2017, 17, 85, 96)
%denom(2018, 18, 97, 108)
%denom(2019, 19, 109, 120)

*Merge data side by side: wide form

data sktemp.Denominator2010_2019_data_prep;
	merge	sktemp.Dn100mod_2010 
			sktemp.Dn100mod_2011 
			sktemp.Dn100mod_2012 
			sktemp.Dn100mod_2013 
			sktemp.Dn100mod_2014 
			sktemp.Dn100mod_2015 
			sktemp.Dn100mod_2016 
			sktemp.Dn100mod_2017 
			sktemp.Dn100mod_2018
			sktemp.Dn100mod_2019;
	by BENE_ID;
run;

*Generate death date variable by combining death date information from each dataset;
data sktemp.Denominator2010_2019_data;
	set sktemp.Denominator2010_2019_data_prep;
	DEATH_DT=DEATH_DT_10;
	if DEATH_DT_10 eq . & DEATH_DT_11 ne . then DEATH_DT=DEATH_DT_11;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 ne . then DEATH_DT=DEATH_DT_12;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 ne . then DEATH_DT=DEATH_DT_13;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 eq . & DEATH_DT_14 ne . then DEATH_DT=DEATH_DT_14;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 eq . & DEATH_DT_14 eq . & DEATH_DT_15 ne . then DEATH_DT=DEATH_DT_15;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 eq . & DEATH_DT_14 eq . & DEATH_DT_15 eq . & DEATH_DT_16 ne . then DEATH_DT=DEATH_DT_16;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 eq . & DEATH_DT_14 eq . & DEATH_DT_15 eq . & DEATH_DT_16 eq . & DEATH_DT_17 ne . then DEATH_DT=DEATH_DT_17;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 eq . & DEATH_DT_14 eq . & DEATH_DT_15 eq . & DEATH_DT_16 eq . & DEATH_DT_17 eq . & DEATH_DT_18 ne . then DEATH_DT=DEATH_DT_18;
	else if DEATH_DT_10 eq . & DEATH_DT_11 eq . & DEATH_DT_12 eq . & DEATH_DT_13 eq . & DEATH_DT_14 eq . & DEATH_DT_15 eq . & DEATH_DT_16 eq . & DEATH_DT_17 eq . & DEATH_DT_18 eq . & DEATH_DT_19 ne . then DEATH_DT=DEATH_DT_19;
run;

/***************************************************************************
***Merge Denominator data and MBSF CC together
***************************************************************************/
proc sql;
	create table sktemp.Denom_MBSF_merged as
	select denom.*, mbsf.* 
	from sktemp.Denominator2010_2019_data as denom
		left join sktemp.mbsf_cc_2010_2019 as mbsf
			on denom.BENE_ID = mbsf.BENE_ID;
quit; 

/****************************************************************************
***Read MedPAR 2010-2019
****************************************************************************/
*2010
data sktemp.MedPAR2010;
	length DGNS_CD01-DGNS_CD10 $7.;
	set Medpar.Mp100mod_2010 (keep = BENE_ID STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD6);
	CLM_TYPE = "  ";
	MEDPAR_YR_NUM = "2010";
run; 

*2011 to 2019
data sktemp.MedPAR2011_2019;
	length ADMSNDT DSCHRGDT 8.;
	set 
		Medpar.Mp100mod_2011 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2012 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2013 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2014 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2015 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2016 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2017 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2018 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		Medpar.Mp100mod_2019 (keep = BENE_ID MEDPAR_YR_NUM STATE_CD SSLSSNF DSCHRGDT SPCLUNIT ADMSNDT DSCHRGCD DSTNTNCD DRG_CD PRVDR_NUM CLM_TYPE DGNS_CD01-DGNS_CD10 PRCDR_CD1-PRCDR_CD25)
		;
run; 

data sktemp.MedPAR2010_2019;
	set sktemp.MedPAR2010
		sktemp.MedPAR2011_2019;
	obs_id = _N_;
	year = input(MEDPAR_YR_NUM, 4.);
	drop MEDPAR_YR_NUM;
run; 


/****************************************************************************
***Merge MedPAR, Denominator, and mbsf data together
****************************************************************************/
proc sql;
	create table sktemp.Merged2010_2019 as
	select medpar.*, denommbsf.* 
	from sktemp.MedPAR2010_2019 as medpar
		left join sktemp.Denom_MBSF_merged as denommbsf
			on medpar.BENE_ID = denommbsf.BENE_ID;
quit; 

*Create flag for dementia
data sktemp.Merged2010_2019_0;
	set sktemp.Merged2010_2019;
	if ALZH_DEMEN_1ST_OCCUR eq . then ALZH_DEMEN_flag=.;
	else if ALZH_DEMEN_1ST_OCCUR > 0 & ADMSNDT >= ALZH_DEMEN_1ST_OCCUR then ALZH_DEMEN_flag=1;
	else if ALZH_DEMEN_1ST_OCCUR > 0 & ADMSNDT < ALZH_DEMEN_1ST_OCCUR then ALZH_DEMEN_flag=0;
	else ALZH_DEMEN_flag=.;
run;

/****************************************************************************
***Define Coverage Type 
****************************************************************************/
data sktemp.Merged2010_2019_1;
	set sktemp.Merged2010_2019_0;
	
	array buyin{120} BUYIN1-BUYIN120;
	array hmoin{120} HMOIND1-HMOIND120;
	
	array elig_period{120} elig_period_1-elig_period_120;
	array elig_period_adm{120} elig_period_adm_1-elig_period_adm_120;
	array elig_period_3month{120} elig_period_3month_1-elig_period_3month_120;

	array enroll_indicator{120} enroll_indicator_1-enroll_indicator_120;
	array elig_indicator{120} elig_indicator_1-elig_indicator_120;
	array elig_3month_indicator{120} elig_3month_indicator_1-elig_3month_indicator_120;
	
	array MA_indicator(120) MA_indicator_1-MA_indicator_120;
	array MA_elig_indicator(120) MA_elig_indicator_1-MA_elig_indicator_120;
	array MA_elig_indicator_3month(120) MA_elig_indicator_3month_1-MA_elig_indicator_3month_120;
	
	array FFS_indicator(120) FFS_indicator_1-FFS_indicator_120;
	array FFS_elig_indicator(120) FFS_elig_indicator_1-FFS_elig_indicator_120;
	
	array dual{120} DUAL1 - DUAL120;
	array dual_indicator{120} dual_indicator_1 - dual_indicator_120;
	array dual_elig_indicator{120} dual_elig_indicator_1 - dual_elig_indicator_120;
	array dual_elig_indicator_adm{120} dual_elig_indicator_adm_1 - dual_elig_indicator_adm_120;
	
	if DEATH_DT ne . & DEATH_DT ge DSCHRGDT 
		then post_dischdt = min(DSCHRGDT + 90, DEATH_DT); 
		else post_dischdt = DSCHRGDT + 90;
	
	do i=1 to 120;
		
		if (year(ADMSNDT) - 2010) * 12 + month(ADMSNDT) le i le (year(post_dischdt) - 2010) * 12 + month(post_dischdt) 
			then elig_period(i)=1; 
	    	else elig_period(i)=0; 
			
		if (year(ADMSNDT) - 2010) * 12 + month(ADMSNDT) eq i 
			then elig_period_adm(i)=1; 
	    	else elig_period_adm(i)=0;
			
		if (year(ADMSNDT) - 2010) * 12 + month(ADMSNDT) le i le (year(ADMSNDT) - 2010) * 12 + month(ADMSNDT) + 2 
			then elig_period_3month(i)=1; 
	    	else elig_period_3month(i)=0; 
		
		*Eligible for Part A & B coverage;
		if buyin(i) in ('3','C') 
			then enroll_indicator(i) = 1;
			else enroll_indicator(i) = 0;
	    	
	    elig_indicator(i) = enroll_indicator(i) * elig_period(i);
		elig_3month_indicator(i) = enroll_indicator(i) * elig_period_3month(i);
	    
		*Eligible for Part A & B - enrolled in MA;
		if buyin(i) in ('3','C') & hmoin(i) not in (' ','0','4') 
			then MA_indicator(i)=1; 
			else MA_indicator(i)=0;
			
		MA_elig_indicator(i) = MA_indicator(i) * elig_period(i);
		MA_elig_indicator_3month(i) = MA_indicator(i) * elig_period_3month(i);
		
		
		*Eligible for Part A & B - enrolled in FFS;
		if buyin(i) in ('3','C') & hmoin(i) in (' ','0','4') 
			then FFS_indicator(i)=1; 
			else FFS_indicator(i)=0;
			
		FFS_elig_indicator(i) = FFS_indicator(i) * elig_period(i);
		
		* dual eligible (full DE);
		if dual(i) in ('02', '04', '08')
			then dual_indicator(i) = 1;
			else dual_indicator(i) = 0;
	
		dual_elig_indicator(i) = dual_indicator(i) * elig_period(i);
		
		* dual eligible at admission month;
		dual_elig_indicator_adm(i) = dual_indicator(i) * elig_period_adm(i);
	 
	end; 
	drop i;
	
	elig_sum = sum(of elig_indicator_1-elig_indicator_120);
	MA_elig_sum = sum(of MA_elig_indicator_1-MA_elig_indicator_120);
	MA_elig_3month_sum = sum(of MA_elig_indicator_3month_1-MA_elig_indicator_3month_120);
	FFS_elig_sum = sum(of FFS_elig_indicator_1-FFS_elig_indicator_120);
	dual_elig_sum = sum(of dual_elig_indicator_1-dual_elig_indicator_120);
	dual_elig_sum_adm = sum(of dual_elig_indicator_adm_1-dual_elig_indicator_adm_120);
	
	*Continuously eligible for Part A;
	if elig_sum eq (year(post_dischdt) - year(ADMSNDT)) * 12 + month(post_dischdt) - month(ADMSNDT) + 1 
		then enrollment_elig=1; 
		else enrollment_elig=0;
	
	*Continuously eligible for Part A - continuously enrolled in MA;
	if MA_elig_sum eq (year(post_dischdt) - year(ADMSNDT)) * 12 + month(post_dischdt) - month(ADMSNDT) + 1 
		then MA_enrollment_elig=1; 
		else MA_enrollment_elig=0;
		
	*Continuously eligible for Part A - continuously enrolled in MA (admission month and two months after);
	if MA_elig_3month_sum eq 3
		then MA_enrollment_elig_3month=1; 
		else MA_enrollment_elig_3month=0;	
	
	*Continuously eligible for Part A - continuously enrolled in FFS;
	if FFS_elig_sum eq (year(post_dischdt) - year(ADMSNDT)) * 12 + month(post_dischdt) - month(ADMSNDT) + 1
		then FFS_enrollment_elig=1;
		else FFS_enrollment_elig=0;
		
	* Continuously eligible for Part A - MA&FFS combination;
	if MA_enrollment_elig=0 & FFS_enrollment_elig=0 then Combo_FFS_MA=1; else Combo_FFS_MA=0; 	
		
	*Ever dual eligible;
	if dual_elig_sum > 0
		then dual_eligible = 1;
		else dual_eligible = 0;
		
	*Dual eligible at adm;
	if dual_elig_sum_adm eq 1
		then dual_eligible_at_adm = 1;
		else dual_eligible_at_adm = 0;
			
	drop BUYIN: HMOIND: DUAL1-DUAL105 enroll_indicator_: elig_period_: elig_period_adm_: elig_period_3month_: elig_indicator_: elig_3month_indicator_:
    	MA_indicator_: MA_elig_indicator_: MA_elig_indicator_3month_: FFS_indicator_: FFS_elig_indicator_:
    	dual_indicator_: dual_elig_indicator_: dual_elig_indicator_adm:;
		
	label MA_enrollment_elig = "Continuous Enrollment in Medicare Advantage" 
		  MA_enrollment_elig_3month = "Enrollment in Medicare Advantage from admission month and two months later"
	      FFS_enrollment_elig = "Continuous Enrollment in Fee-for-Service"
		  Combo_FFS_MA="Combination of Fee-for-Service and Medicare Advantage"
		  dual_eligible = "Ever dual eligible"
		  dual_eligible_at_adm = "Dual eligible at admission month";
run; 

/*******************************************************************************
***Apply MedPAR inclusion/exclusion
*******************************************************************************/
*1. include discharge admitted 4/1/2010 - 3/31/2019
data sktemp.step1;
	set sktemp.Merged2010_2019_1;
	if ADMSNDT >= '01APR2010'd and ADMSNDT <= '31MAR2019'd;
run;  

*2. Exclude MedPAR discharges after September 30,2018
data sktemp.step2;
	set sktemp.step1;
	if DSCHRGDT <= '30SEP2018'd;
run; 

*3. Exclude MA patients 
data sktemp.step3;
	set sktemp.step2;
	if MA_enrollment_elig_3month = 0;
run;

*4. Exclude those less than 65 years old at admission date
data sktemp.step4;
	set sktemp.step3;
	age_adm = floor((intck('month',BENE_DOB,ADMSNDT) - (day(ADMSNDT) < day(BENE_DOB)))/12);
	if age_adm>=65;
	* combine race group;
	if race = 1 then raceeth = 1;
	else if race = 2 then raceeth = 2;
	else if race in (3, 4, 6) then raceeth = 3;
	else if race = 5 then raceeth = 4;
	else if race = 0 then raceeth = 5;
	else raceeth = 5;
run;   

*5. Include discharge from acute hospitals
data sktemp.step5;
	set sktemp.step4;
	if 
		(year = 2010 
		& (substr(PRVDR_NUM,3,1) in ('0','M','R','S','T') or substr(PRVDR_NUM,3,2)= '13')
		& SPCLUNIT not in ('M','R','S','T')) 
		OR 
		(year ^= 2010 
		& (substr(PRVDR_NUM,3,1) in ('0','M','R','S','T') or substr(PRVDR_NUM,3,2)= '13')
		& SPCLUNIT not in ('M','R','S','T') 
		& CLM_TYPE in ("60", "61", "62", "63", "64"));
run;

*Create year and month varaibles for discharge date and admission date;
data sktemp.Merged2010_2019_data;
	set sktemp.step5;
	dschrg_year = year(DSCHRGDT);
	dschrg_month = month(DSCHRGDT);
	admission_year = year(ADMSNDT);
	admission_month = month(ADMSNDT);
run; 

/***************************************************************************
***Add Elixhauser Index based on index hospitalization
***************************************************************************/
*Separate the data set by whether using ICD-10;
*ICD-10 has been used for diagnosis code starting from October 2015;

data sktemp.medpar_icd9 sktemp.medpar_icd10;
	set sktemp.Merged2010_2019_data
		(keep = obs_id DGNS_CD01-DGNS_CD10 dschrg_year dschrg_month);
	if (dschrg_year = 2015 and dschrg_month in (10,11,12)) or dschrg_year > 2015
		then output sktemp.medpar_icd10;
		else output sktemp.medpar_icd9; 
run;

*Use SAS Macro developed by Manitoba Center for Health Policy to create the 31 comorbidity index;
*Reference: http://mchp-appserv.cpe.umanitoba.ca/viewConcept.php?conceptID=1436;
%include "/project/pac_caregiving/oasis_xc_workspace/program/macro_Elixhauser.sas";

*ICD-9
*Create a temp file for calling macro;
data medpar_icd9;
   set sktemp.medpar_icd9;
run;

*Call macro;
   %_ElixhauserICD9CM (DATA    = medpar_icd9,
                       OUT     = sktemp.medpar_icd9_elix,
                       dx      = DGNS_CD01-DGNS_CD10,
                       dxtype  = ,
                       type    = off, 
                       debug   = off);					   



proc freq data = sktemp.medpar_icd9_elix;
   title1  "Summary of Elixhauser Comorbidity Groups - ICD-9";
   tables  ELX_GRP: TOT_GRP;
run; 

*ICD-10 
*Create a temp file for calling macro;
data medpar_icd10;
   set sktemp.medpar_icd10;
run;

*Call macro;
   %_ElixhauserICD10  (DATA    = medpar_icd10,
                       OUT     = sktemp.medpar_icd10_elix,
                       dx      = DGNS_CD01-DGNS_CD10,
                       dxtype  = ,
                       type    = off, 
                       debug   = off);					   


proc freq data = sktemp.medpar_icd10_elix;
   title1  "Summary of Elixhauser Comorbidity Groups - ICD-10";
   tables  ELX_GRP: TOT_GRP;
run; 

*Combine cohort of ICD-9 with cohort of ICD-10;
data sktemp.medpar_elix_2010_2019 (drop=i);
	 set sktemp.medpar_icd9_elix  
	     sktemp.medpar_icd10_elix; 
run;

proc freq data = sktemp.medpar_elix_2010_2019;
   title1  "Summary of Elixhauser Comorbidity Groups - ALL";
   tables  ELX_GRP: TOT_GRP;
run;

*Rename Elixhauser variables;
* (later we will add another set of Elixhauser scores based on prior hospitalizations);
%macro rename3(oldprefix, newprefix, num);
  %let k=1;
     %do %while(&k <= &num);
      rename &oldprefix.&k  = &newprefix.&k;
	  %let k = %eval(&k + 1);
  %end;
%mend;

data sktemp.medpar_elix_2010_2019;
	set sktemp.medpar_elix_2010_2019;
	%rename3(ELX_GRP_, index_ELX_GRP_, 31);
	rename TOT_GRP = index_TOT_GRP;
run;

%varlist(sktemp.medpar_elix_2010_2019)

*Merge Elixhauser variables back to main MedPAR data;
proc sql;
	create table sktemp.Merged2010_2019_2 as
	select *
	from sktemp.Merged2010_2019_data as a
		join 
		sktemp.medpar_elix_2010_2019
		(keep = obs_id index_: rename = (obs_id = obs_id_elix)) as b 
			on a.obs_id = b.obs_id_elix;
quit;   

/*****************************************************************************
***Add indicator varaibles for 6 conditions based on DRG
*****************************************************************************/

data sktemp.Merged2010_2019_3;
	set sktemp.Merged2010_2019_2;
	
	if DRG_CD in (469,470) then tkr_thr_drg = 1; else tkr_thr_drg = 0;
	if DRG_CD in (871,872) then sepsis_drg = 1; else sepsis_drg = 0;
	if DRG_CD in (689,690) then uti_drg = 1; else uti_drg = 0;
	if DRG_CD in (291,292,293) then chf_drg = 1; else chf_drg = 0;
	if DRG_CD in (193,194,195) then pneu_drg = 1; else pneu_drg = 0;
	if DRG_CD in (480,481,482,535,536) then hipfx_drg = 1; else hipfx_drg = 0;
	
	* Mortality;
	if DSCHRGDT le DEATH_DT le DSCHRGDT + 30 
		then DeadIn30Days = 1; 
		else DeadIn30Days = 0;
run; 

/*****************************************************************************
***Add MSA code 
*****************************************************************************/
*Merge main MedPAR data to PRVDR_NUM-MSA crosswalk;
proc sql;
	create table sktemp.Merged2010_2019_4 as
	select a.* , b.CITY_NAME, b.PRVDR_NUM, b.MSA
	from sktemp.Merged2010_2019_3 as a
		left join 
		oadat.provider_number_msa_crosswalk as b
			on a.PRVDR_NUM = b.PRVDR_NUM
			and a.admission_year=b.year;
quit;   
           

*Add indicator for BPCI participation

proc sql;
	create table sktemp.Merged2010_2019_5 as 
	select a.*, b.bpci_ever_participated
	from sktemp.Merged2010_2019_4 as a 
		left join 
		oadat.bpci_ever_participated as b 
			on a.PRVDR_NUM = b.CCN;
quit; 

*CJR starts on 4/1/2016
proc sql;
	create table sktemp.Merged2010_2019_6 as 
	select a.*, b.cjr_ind
	from sktemp.Merged2010_2019_5 as a 
		left join 
		oadat.cjr_enroll_final as b
			on a.PRVDR_NUM = b.CCN 
				and a.DRG_CD in (469, 470)
				and a.ADMSNDT >= 20545;
quit;  


proc sql;
	create table sktemp.Merged2010_2019_7 as 
	select a.*, 
		(case when b.cjr_ind = 1 then 1 else 0 end) as cjr_elig
	from sktemp.Merged2010_2019_6 as a 
		left join 
		oadat.cjr_enroll_final as b
			on a.PRVDR_NUM = b.CCN;	 
quit;  

*Add indicator for CJR participation
proc sql;
	create table sktemp.Merged2010_2019_8 as 
	select a.*, b.*
	from sktemp.Merged2010_2019_7 as a 
		left join 
		oadat.cjr_participant_final as b
			on a.MSA= b.MSA ;
quit; 

*Keep only 196 MSAs that were eligible for CJR Participation
DATA sktemp.Merged2010_2019_9; 
	SET sktemp.Merged2010_2019_8;
	IF MSA_196_list=1 then OUTPUT;
RUN;

*Exclude bpci participants
DATA sktemp.Merged2010_2019_10; 
	SET sktemp.Merged2010_2019_9; 
	IF missing(bpci_ever_participated) then OUTPUT;
RUN;

/***************************************************************************
*** Keep hospitals from knee/hip cohort 
***************************************************************************/

*First keep knee/hip only and get the PRVDR_NUM 
data sktemp.kneehip;
	set sktemp.Merged2010_2019_10;
	if DRG_CD in (469,470)
	then output;
run;
 
*Drop duplicates in PRVDR_NUM
proc sort data = sktemp.kneehip out = sktemp.kneehip_2 nodupkey;
	by PRVDR_NUM; 
run;

data sktemp.kneehip_2; 
	set sktemp.kneehip_2;
	same_provider=1; 
run; 

*Add indicator for same provider as knee/hip
proc sql;
	create table sktemp.Merged2010_2019_11 as 
	select a.*, b.same_provider
	from sktemp.Merged2010_2019_10 as a 
		left join 
		sktemp.kneehip_2 as b
			on a.PRVDR_NUM= b.PRVDR_NUM;
quit;

*Only keeep if same_provider=1
DATA sktemp.Merged2010_2019_12; 
	SET sktemp.Merged2010_2019_11; 
	IF same_provider=1 then output; 
RUN;

*Exclude DRG's that are not needed
data sktemp.Merged2010_2019_13;
	set sktemp.Merged2010_2019_12;
	if DRG_CD in (469,470)
	or DRG_CD in (871,872) 
	or DRG_CD in (689,690)
	or DRG_CD in (291,292,293)
    or DRG_CD in (193,194,195)
    or DRG_CD in (480,481,482,535,536)
	then output;
run;

*Get unique record for each BENE_ID on same discharge date;
proc sql;
	create table sktemp.Merged2010_2019_13 as
	select * 
	from sktemp.Merged2010_2019_13
	order by BENE_ID, DSCHRGDT, obs_id;
quit; 

data sktemp.Merged2010_2019_14;
	set sktemp.Merged2010_2019_13;
	by BENE_ID DSCHRGDT;
	if first.DSCHRGDT;
run;

/*****************************************************************************
***Add length of MedPAR stay
*****************************************************************************/
data sktemp.Merged2010_2019_14;
	set sktemp.Merged2010_2019_14;
	los_medpar = DSCHRGDT - ADMSNDT;
run;

/***************************************************************************
***Final MedPAR working dataset
***************************************************************************/
data sktemp.Merged2010_2019_final;
	set sktemp.Merged2010_2019_14;
	drop DGNS_CD: DEATH_DT_:;
run; 

*Export to Stata*
proc export data=sktemp.Merged2010_2019_final
dbms=dta outfile='/project/pac_caregiving/nhats_sk_workspace/output/cohort_A_08262022' replace;
run;

