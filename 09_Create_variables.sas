/****************************************************************************
***Step 9: Create variables 
****************************************************************************/
/******************************************************************************
***Code caregiving variables (at OASIS assessment level)
******************************************************************************/
*Note the difference in response values before/after 2015;
proc sql;	
	select count(*) as n, count(distinct obs_id) as n_dischg, count(distinct bene_id) as n_bene
	from oatemp.merge_all_2010_2019_2;
	
	select count(*) as n, count(distinct obs_id) as n_dischg, count(distinct bene_id) as n_bene
	from oatemp.merge_all_2010_2019_2
	where assess_type = 1;
	
	select count(*) as n, count(distinct obs_id) as n_dischg, count(distinct bene_id) as n_bene
	from oatemp.merge_all_2010_2019_2
	where assess_type = 3;
quit;


data oatemp.oasis_merged_prep;
	set oatemp.merge_all_2010_2019_2;
*	if assess_type = &type.;
	
	dschrg_year=year(dschrgdt);
	
	array M2100{7} M2100_ADL--M2100_SFTY;
	array M2100_yn{7} 	M2100_ADL_yn
						M2100_ADVCY_yn
						M2100_IADL_yn
						M2100_EQUIP_yn 
						M2100_PRCDR_yn 
						M2100_MDCTN_yn 
						M2100_SFTY_yn;

	array M2100_need{7}	M2100_ADL_need
						M2100_ADVCY_need
						M2100_IADL_need
						M2100_EQUIP_need 
						M2100_PRCDR_need 
						M2100_MDCTN_need 
						M2100_SFTY_need;

	array M2100_yn_w_need{7} M2100_ADL_yn_w_need
							M2100_ADVCY_yn_w_need
							M2100_IADL_yn_w_need
							M2100_EQUIP_yn_w_need
							M2100_PRCDR_yn_w_need 
							M2100_MDCTN_yn_w_need 
							M2100_SFTY_yn_w_need;
	
	if oasis_year in (2010, 2011, 2012, 2013, 2014) then
	do;
		do i = 1 to 7;
			if M2100(i) = 0 then do;
				M2100_yn(i) = 0;
				M2100_need(i) = 0;
				M2100_yn_w_need(i) = .;
			end;
				else if M2100(i) = 1 then do;
					M2100_yn(i) = 1;
					M2100_need(i) = 1;
					M2100_yn_w_need(i) = 1;
				end;
				else if M2100(i) > 1 then do;
					M2100_yn(i) = 0;
					M2100_need(i) = 1;
					M2100_yn_w_need(i) = 0;
				end;
		end;
		drop i;
	end;
	
	else if oasis_year in (2015, 2016, 2017, 2018, 2019) then
	do;
		do i = 1 to 7;
			if M2100(i) = 0 then do;
				M2100_yn(i) = 0;
				M2100_need(i) = 0;
				M2100_yn_w_need(i) = .;
			end;
				else if M2100(i) = 1 then do;
					M2100_yn(i) = 1;
					M2100_need(i) = 1;
					M2100_yn_w_need(i) = 1;
				end;
				else if M2100(i) > 1 then do;
					M2100_yn(i) = 0;
					M2100_need(i) = 1;
					M2100_yn_w_need(i) = 0;
				end;
		end;
		drop i;
	end; 

	if M2100_ADL_yn = 1 or M2100_ADVCY_yn = 1 or M2100_IADL_yn = 1 or
       M2100_EQUIP_yn = 1 or M2100_PRCDR_yn = 1 or M2100_MDCTN_yn = 1 or 
	   M2100_SFTY_yn = 1
	then caregiving_yn = 1;
		else caregiving_yn = 0;
		
	if M2100_ADL_yn_w_need = 1 or M2100_ADVCY_yn_w_need = 1 or M2100_IADL_yn_w_need = 1 or
       M2100_EQUIP_yn_w_need = 1 or M2100_PRCDR_yn_w_need = 1 or M2100_MDCTN_yn_w_need = 1 or 
	   M2100_SFTY_yn_w_need = 1
	then caregiving_yn_w_need = 1;
		else if M2100_ADL_yn_w_need = . and M2100_ADVCY_yn_w_need = . and M2100_IADL_yn_w_need = . and 
				M2100_EQUIP_yn_w_need = . and M2100_PRCDR_yn_w_need = . and M2100_MDCTN_yn_w_need = . and  
				M2100_SFTY_yn_w_need = .
		then caregiving_yn_w_need = .;
		else caregiving_yn_w_need = 0;
		
	array M1900{4} M1900_AMB--M1900_TRN;
	array M1900_yn{4} M1900_AMB_yn M1900_HSH_yn M1900_SEL_yn M1900_TRN_yn;
	
	do i = 1 to 4;
		if M1900(i) = 0 then M1900_yn(i) = 0;
			else if M1900(i) > 0 then M1900_yn(i) = 1;
	end;
	drop i;

	if M1900_AMB_yn = 1 or M1900_HSH_yn = 1 or M1900_SEL_yn = 1 or
       M1900_TRN_yn = 1 
	then needhelp_yn = 1;
		else if M1900_AMB_yn = . and M1900_HSH_yn = . and M1900_SEL_yn = . and
		M1900_TRN_yn = .
		then needhelp_yn = -1;
		else needhelp_yn = 0;
run;

/*******************************************************************************
***Split data into admission & discharge, and reshape to MedPAR discharge level
*****************************************************************************/
%macro rename1(oldvarlist, suffix);
  %let k=1;
  %let old = %scan(&oldvarlist, &k);
     %do %while("&old" NE "");
      rename &old = &old.&suffix;
	  %let k = %eval(&k + 1);
      %let old = %scan(&oldvarlist, &k);
  %end;
%mend;

%macro sep(type, suffix);

data oatemp.oasis_prep&suffix;
	set oatemp.oasis_merged_prep;
	if assess_type = &type.;
	%rename1(
			M2100_ADL
			M2100_ADVCY
			M2100_IADL
			M2100_EQUIP
			M2100_PRCDR
			M2100_MDCTN
			M2100_SFTY
			M2100_ADL_yn
			M2100_ADVCY_yn
			M2100_IADL_yn
			M2100_EQUIP_yn 
			M2100_PRCDR_yn 
			M2100_MDCTN_yn 
			M2100_SFTY_yn
			caregiving_yn
			M2100_ADL_need
			M2100_ADVCY_need
			M2100_IADL_need
			M2100_EQUIP_need 
			M2100_PRCDR_need 
			M2100_MDCTN_need 
			M2100_SFTY_need
			M2100_ADL_yn_w_need
			M2100_ADVCY_yn_w_need
			M2100_IADL_yn_w_need
			M2100_EQUIP_yn_w_need
			M2100_PRCDR_yn_w_need 
			M2100_MDCTN_yn_w_need 
			M2100_SFTY_yn_w_need
			caregiving_yn_w_need
			M2110_ADL_IADL_FREQ
			M1700_CGNTV
			M1900_AMB_yn 
			M1900_HSH_yn 
			M1900_SEL_yn 
			M1900_TRN_yn
			needhelp_yn
			ADL_bath
			ADL_dress
			ADL_toilet
			ADL_trans
			ADL_eating
			ADL_uri
			ADL_bwl
			ADL_5_total
			ADL_6_total
			flag_ADL_5_impair
			flag_ADL_6_impair
			MADL_trans
			MADL_ambl
			flag_MADL_impair
			M1880
			M1890
			
			,
			&suffix.); 
run;
		
%mend sep;
%sep(1, _adm)
%sep(3, _dis)

*Merge back to single discharge level;
proc sql;
	create table oatemp.oasis_merged_dischg_lvl as
	select *
	from oatemp.oasis_prep_adm 
			(drop = DSCHRG_DEATH_DATE) as a
		left join 
			oatemp.oasis_prep_dis 
			(keep = obs_id 
			DSCHRG_DEATH_DATE
			M2100_ADL_dis
			M2100_ADVCY_dis
			M2100_IADL_dis
			M2100_EQUIP_dis
			M2100_PRCDR_dis
			M2100_MDCTN_dis
			M2100_SFTY_dis
			M2100_ADL_yn_dis
			M2100_ADVCY_yn_dis
			M2100_IADL_yn_dis
			M2100_EQUIP_yn_dis
			M2100_PRCDR_yn_dis 
			M2100_MDCTN_yn_dis 
			M2100_SFTY_yn_dis
			caregiving_yn_dis
			M2100_ADL_need_dis
			M2100_ADVCY_need_dis
			M2100_IADL_need_dis
			M2100_EQUIP_need_dis 
			M2100_PRCDR_need_dis 
			M2100_MDCTN_need_dis 
			M2100_SFTY_need_dis
			M2100_ADL_yn_w_need_dis
			M2100_ADVCY_yn_w_need_dis
			M2100_IADL_yn_w_need_dis
			M2100_EQUIP_yn_w_need_dis
			M2100_PRCDR_yn_w_need_dis 
			M2100_MDCTN_yn_w_need_dis 
			M2100_SFTY_yn_w_need_dis
			caregiving_yn_w_need_dis
			M2110_ADL_IADL_FREQ_dis
			M1700_CGNTV_dis
			M1900_AMB_yn_dis M1900_HSH_yn_dis M1900_SEL_yn_dis M1900_TRN_yn_dis
			needhelp_yn_dis
			ADL_bath_dis
			ADL_dress_dis
			ADL_toilet_dis
			ADL_trans_dis
			ADL_eating_dis
			ADL_uri_dis
			ADL_bwl_dis
			ADL_6_total_dis
			ADL_5_total_dis
			flag_ADL_6_impair_dis
			flag_ADL_5_impair_dis
			MADL_trans_dis
			MADL_ambl_dis
			flag_MADL_impair_dis
			M1880_dis
			M1890_dis
			rename = (obs_id = obs_id_dis)) as b
			on a.obs_id = b.obs_id_dis;
quit;

/****************************************************************************
***Add length of MedPAR/HHA stay
*****************************************************************************/
data oatemp.oasis_merged_dischg_lvl3;
	set oatemp.oasis_merged_dischg_lvl;
	los_hha = DSCHRG_DEATH_DATE - INDEX_DATE;
	if los_hha < 0 then los_hha = .; 
run;


/*******************************************************************************
***Merge in longitunidal Elixhauser score (created in prep_Elixhauser.sas)
******************************************************************************/
/*Approach: Elixhauser Comorbidity Index score (the total number of categories
   indicated) for an individual MedPAR discharge, based on ALL episodes of care 
   (hospitalizations) over a specified period of time (one year prior to index admission).
   Each category is only counted once in the overall total count per person. */
proc sql;
	create table oatemp.elix_score as 
	select a.obs_id, 
		max(ELX_GRP_1) as elixgrp1, 
		max(ELX_GRP_2) as elixgrp2, 
		max(ELX_GRP_3) as elixgrp3, 
		max(ELX_GRP_4) as elixgrp4, 
		max(ELX_GRP_5) as elixgrp5, 
		max(ELX_GRP_6) as elixgrp6, 
		max(ELX_GRP_7) as elixgrp7, 
		max(ELX_GRP_8) as elixgrp8, 
		max(ELX_GRP_9) as elixgrp9, 
		max(ELX_GRP_10) as elixgrp10, 
		max(ELX_GRP_11) as elixgrp11, 
		max(ELX_GRP_12) as elixgrp12, 
		max(ELX_GRP_13) as elixgrp13, 
		max(ELX_GRP_14) as elixgrp14, 
		max(ELX_GRP_15) as elixgrp15, 
		max(ELX_GRP_16) as elixgrp16, 
		max(ELX_GRP_17) as elixgrp17, 
		max(ELX_GRP_18) as elixgrp18, 
		max(ELX_GRP_19) as elixgrp19, 
		max(ELX_GRP_20) as elixgrp20, 
		max(ELX_GRP_21) as elixgrp21, 
		max(ELX_GRP_22) as elixgrp22, 
		max(ELX_GRP_23) as elixgrp23, 
		max(ELX_GRP_24) as elixgrp24, 
		max(ELX_GRP_25) as elixgrp25, 
		max(ELX_GRP_26) as elixgrp26, 
		max(ELX_GRP_27) as elixgrp27, 
		max(ELX_GRP_28) as elixgrp28, 
		max(ELX_GRP_29) as elixgrp29, 
		max(ELX_GRP_30) as elixgrp30, 
		max(ELX_GRP_31) as elixgrp31
	from oatemp.oasis_merged_dischg_lvl3 as a
		left join 
		sktemp.elixhauser_2009_2019 as b
			on a.bene_id = b.bene_id
				and 0 < a.ADMSNDT - b.ADMSNDT <= 365 
	group by a.obs_id;
quit;  

data oatemp.elix_score;
	set oatemp.elix_score;
	totalelix = sum(of elixgrp1-elixgrp31);
run;

proc sql;
	create table oatemp.oasis_merged_dischg_lvl4 as
	select a.*, b.totalelix
	from oatemp.oasis_merged_dischg_lvl3 as a
		join oatemp.elix_score as b
			on a.obs_id = b.obs_id;
	
	select count(*) as n, count(distinct obs_id) as n_dischg
	from oatemp.oasis_merged_dischg_lvl4; 
	
	select count(*) as n, count(distinct obs_id) as n_dischg
	from oatemp.oasis_merged_dischg_lvl4
	where obs_id_dis = .;
quit;

*Generate indicator for received home health
data  oatemp.oasis_merged_dischg_lvl4;
	set oatemp.oasis_merged_dischg_lvl4;
	RECEIVE_HOME_HEALTH = 1;
run;

/*******************************************************************************
*** extract useful variables for analytical datasets
*****************************************************************************/
proc sql;
	create table oatemp.cohort_B_C_20220826 as
	select *
	from oatemp.oasis_merged_dischg_lvl4
		(keep = BENE_ID obs_id obs_id_dis dschrg_year DSCHRGDT dschrg_month ADMSNDT admission_year admission_month
				age_adm raceeth sex STATE_CD
				los_hha los_medpar index_TOT_GRP index_ELX_GRP_:
				cjr_ind cjr_elig
				ALZH_DEMEN_flag DRG_CD PRCDR_CD: MSA 
				totalelix ma_enrollment_elig ma_enrollment_elig_3month dual_eligible PRVDR_NUM
				tkr_thr_drg sepsis_drg uti_drg chf_drg pneu_drg hipfx_drg
				M1700_: M2100_: M2110_: M1880_: M1890_:
				M2100_ADL_yn_adm--needhelp_yn_adm
				M2100_ADL_yn_dis--needhelp_yn_dis
				ADL_: MADL_: flag_ADL_5_impair: flag_ADL_6_impair: 
				flag_MADL_impair: VISITCNT_HHA FFS_ENROLLMENT_ELIG 
				M0150_MDCD_FFS_PMT_CD M0150_MDCR_FFS_PMT_CD DUAL_ELIGIBLE_AT_ADM M0100_RSN_FOR_ASMT_CD M0030_STRT_CARE_DT M0032_ROC_DT PMT_AMT_HHA ADMSNDT_HHA
				M0140: RECEIVE_HOME_HEALTH);
	
	select count(*) as n, count(distinct obs_id) as n_dischg
	from oatemp.analytical_20220126; 
	
	select count(*) as n, count(distinct obs_id) as n_dischg
	from oatemp.analytical_20220126
	where obs_id_dis = .;

quit;


