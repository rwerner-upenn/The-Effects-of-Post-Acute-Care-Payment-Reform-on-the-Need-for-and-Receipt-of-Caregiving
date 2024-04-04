/****************************************************************************
***Step 8: Merge with HHA claims 
****************************************************************************/

/****************************************************************************
*Create unique id for each observation in the OASIS-Medpar merged file  
*****************************************************************************/
data "/project/pac_caregiving/oasis_sk_workspace/tempdata/oasis_merged.sas7bdat";
set "/project/pac_caregiving/oasis_sk_workspace/tempdata/oasis_merged.sas7bdat";
row_ID=_n_;
run;
	
/**************************************************************************
*Change date format 
**************************************************************************/
data oatemp.oasis_merged;
set oatemp.oasis_merged;
STRT_CARE_DT=input(M0030_STRT_CARE_DT,yymmdd10.);
format STRT_CARE_DT date9.;
run;

data oatemp.oasis_merged;
set oatemp.oasis_merged;
RESUM_CARE_DT=input(M0032_ROC_DT,yymmdd10.);
format RESUM_CARE_DT date9.;
run; 

/**************************************************************************************************************
*Merge based on bene id and difference of claim from date from HHA claims and start care date from Medpar-OASIS
***************************************************************************************************************/
proc sql;
create table oatemp.merge_all_2010_2019 as 
select a.*,
	   b. CLM_FROM_DT as ADMSNDT_HHA, b.CLM_HHA_TOT_VISIT_CNT as VISITCNT_HHA, b. CLM_PMT_AMT as PMT_AMT_HHA, b.CLM_ID as CLM_ID_HHA
from oatemp.oasis_merged as a
left join hhatemp.hha2010_2018_unique as b on a.bene_id=b.bene_id and -3<=b.CLM_FROM_DT-a.STRT_CARE_DT <=3;
quit;

/****************************************************************************************************
*Calculate the absolute value of difference between admission dates in OASIS versus HHA claim 
***************************************************************************************************/
data oatemp.merge_all_2010_2019_2;
set oatemp.merge_all_2010_2019;
admsndt_diff=abs(STRT_CARE_DT-ADMSNDT_HHA);
run;

/****************************************************************************************************
*Sort the data set by id and absolute value of difference 
****************************************************************************************************/
proc sort data=oatemp.merge_all_2010_2019_2;
by row_ID admsndt_diff;
run;

/******************************************************************************************************
* Keep the smallest difference for each row_ID from OASIS-Medpar
******************************************************************************************************/
data oatemp.merge_all_2010_2019_2;
set oatemp.merge_all_2010_2019_2;
by row_ID admsndt_diff;
if first.row_ID;
run;
