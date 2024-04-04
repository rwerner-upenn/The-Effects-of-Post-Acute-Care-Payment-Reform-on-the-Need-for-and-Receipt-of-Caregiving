/****************************************************************************
***Step 2: Clean up MBSF_CC
****************************************************************************/

/***************************************************************************
***Read MBSF_CC 2010-2019
***************************************************************************/
*Append MBSF_CC 2010 to 2019
data sktemp.mbsf_cc_2010_2019;
	set MBSFCC.mbsf_cc_summary_2010 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2011 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2012 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2013 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2014 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2015 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2016 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2017 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2018 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		MBSFCC.mbsf_cc_summary_2019 (keep = BENE_ID BENE_ENROLLMT_REF_YR ALZH_DEMEN ALZH_DEMEN_MID ALZH_DEMEN_EVER)
		;     
run;

*Add years next to variables using the BENE_ENROLLMT_REF_YR so we know what year the variable came from
%macro cc(year, yr);

data sktemp.mbsf_cc_&year.;
	set sktemp.mbsf_cc_2010_2019; 
	if BENE_ENROLLMT_REF_YR = &year.; 	
	rename	ALZH_DEMEN = ALZH_DEMEN_&yr.
			ALZH_DEMEN_MID = ALZH_DEMEN_MID_&yr.
			ALZH_DEMEN_EVER = ALZH_DEMEN_EVER_&yr.
			;
	drop BENE_ENROLLMT_REF_YR;
run;

proc sort data=sktemp.mbsf_cc_&year.; by BENE_ID; run;

%mend cc;
%cc(2010, 10)
%cc(2011, 11)
%cc(2012, 12)
%cc(2013, 13)
%cc(2014, 14)
%cc(2015, 15)
%cc(2016, 16)
%cc(2017, 17)
%cc(2018, 18)
%cc(2019, 19)

*Merge each years side by side to get first occurance of ALZH/DEMEN 

data sktemp.mbsf_cc_2010_2019;
	merge	sktemp.mbsf_cc_2010 
			sktemp.mbsf_cc_2011 
			sktemp.mbsf_cc_2012 
			sktemp.mbsf_cc_2013 
			sktemp.mbsf_cc_2014 
			sktemp.mbsf_cc_2015 
			sktemp.mbsf_cc_2016 
			sktemp.mbsf_cc_2017 
			sktemp.mbsf_cc_2018
			sktemp.mbsf_cc_2019;
	by BENE_ID;
	* create 1st occurrance of condition;
	ALZH_DEMEN_1st_occur = min(of ALZH_DEMEN_EVER_10-ALZH_DEMEN_EVER_19);
run; 
