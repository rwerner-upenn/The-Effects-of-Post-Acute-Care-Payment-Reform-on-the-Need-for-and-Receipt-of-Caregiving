/****************************************************************************
***Step 5: Clean up HHA claims 
****************************************************************************/

/*******************************************************************************
*** Read in HHA data 2010-2018
*******************************************************************************/
proc sql;
create table hhatemp.hha2010_2018 as 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT, 	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004952_2010 union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT, 	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004953_2010 union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT, 	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004953_2011 union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT, 	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004954_2011 union all
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT, 	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004954_2012 union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004955_2012 union all  
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004955_2013 union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA.hha_base_claims_j_req004956_2013 union all
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA2014.hha_base_claims union all  
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA2015.hha_base_claims union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA2016.hha_base_claims union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA2017.hha_base_claims_k_2017 union all 
select BENE_ID, CLM_ID, PRVDR_NUM, CLM_FROM_DT, CLM_THRU_DT, CLM_ADMSN_DT, CLM_PMT_AMT, CLM_HHA_TOT_VISIT_CNT,	BENE_STATE_CD, PRVDR_STATE_CD, CLM_HHA_LUPA_IND_CD, CLM_FAC_TYPE_CD from HHA2018.hha_base_claims_k_2018 
order by BENE_ID, CLM_FROM_DT;
quit;

/*******************************************************************************
*Handle BENE_ID, CLM_FROM_DT duplicates
*If BENE_ID, CLM_FROM_DT and CLM_HHA_TOT_VISIT_CNT is the same, keep one randomly
*If BENE_ID, CLM_FROM_DT is same but CLM_HHA_TOT_VISIT_CNT is different 
*keep higher CLM_HHA_TOT_VISIT_CNT 
*******************************************************************************/
*Sort by BENE_ID, CLM_FROM_DT, CLM_HHA_TOT_VISIT_CNT
proc sort data=hhatemp.hha2010_2018;
by BENE_ID CLM_FROM_DT CLM_HHA_TOT_VISIT_CNT;
run; 

*Keep the one with higher CLM_HHA_TOT_VISIT_CNT
data hhatemp.hha2010_2018_unique;
set hhatemp.hha2010_2018;
by BENE_ID CLM_FROM_DT ; 
if last.CLM_FROM_DT then output;
run; 