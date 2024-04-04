/****************************************************************************
***Step 6: Create Elixhauser based on one year prior hospitalizations
****************************************************************************/

/*******************************************************************************
***Read MedPAR 2009-2019 (we want 1-year prior hospitalizations for 2010-2019)
******************************************************************************/
*Create a data set to store the first 10 diagnosis codes of each claim;
*2010
data sktemp.dgns_2009_2010;
	length PRVDR_NUM $10.;
	length DGNS_CD01-DGNS_CD10 $7.;
	set Medpar.Mp100mod_2009 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10)
		Medpar.Mp100mod_2010 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10)
		;
	if (substr(PRVDR_NUM,3,1) in ('0','M','R','S','T') or substr(PRVDR_NUM,3,2) = '13')
		& SPCLUNIT not in ('M','R','S','T');
	CLY_TYPE = "";
	dschrg_year = year(DSCHRGDT);
	dschrg_month = month(DSCHRGDT);
run; 

*2011-2019
data sktemp.dgns_2011_2019;
	length ADMSNDT DSCHRGDT 8.;
	set Medpar.Mp100mod_2011 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2012 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2013 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2014 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2015 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2016 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2017 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2018 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		Medpar.Mp100mod_2019 (keep = BENE_ID DSCHRGDT ADMSNDT PRVDR_NUM SPCLUNIT DGNS_CD01-DGNS_CD10 CLM_TYPE)
		;
	if (substr(PRVDR_NUM,3,1) in ('0','M','R','S','T') or substr(PRVDR_NUM,3,2)= '13')
		& SPCLUNIT not in ('M','R','S','T') 
		& CLM_TYPE in ("60", "61", "62", "63", "64");
	dschrg_year = year(DSCHRGDT);
	dschrg_month = month(DSCHRGDT);
run; 

*Separate the data set by whether using ICD-10;
*ICD-10 has been used for diagnosis code starting from October 2015;

data sktemp.dgns_2009_2019_icd9 sktemp.dgns_2009_2019_icd10;
	set sktemp.dgns_2009_2010
		sktemp.dgns_2011_2019
		;
	if (dschrg_year = 2015 and dschrg_month in (10,11,12)) or dschrg_year > 2015
		then output sktemp.dgns_2009_2019_icd10; 
		else output sktemp.dgns_2009_2019_icd9; 
run;

/*******************************************************************************
***Create Elixhauser Comorbidity Index Variables; 
******************************************************************************/
*Use SAS Macro developed by Manitoba Center for Health Policy to create the 31 comorbidity index;
*Reference: http://mchp-appserv.cpe.umanitoba.ca/viewConcept.php?conceptID=1436;

%include "/project/pac_caregiving/oasis_xc_workspace/program/macro_Elixhauser.sas";

*ICD-9 
*Create a temp file for calling macro;
data dgns_2009_2019_icd9;
   set sktemp.dgns_2009_2019_icd9;
run;

*Call macro;
   %_ElixhauserICD9CM (DATA    = dgns_2009_2019_icd9,
                       OUT     = sktemp.dgns_2009_2019_icd9_elix,
                       dx      = DGNS_CD01-DGNS_CD10,
                       dxtype  = ,
                       type    = off, 
                       debug   = off);					   

proc freq data = sktemp.dgns_2009_2018_icd9_elix;
   title1  "Summary of Elixhauser Comorbidity Groups - ICD-9";
   tables  ELX_GRP: TOT_GRP;
run;

*ICD-10 
*Create a temp file for calling macro;
data dgns_2009_2019_icd10;
   set sktemp.dgns_2009_2019_icd10;
run;

*Call macro;
   %_ElixhauserICD10  (DATA    = dgns_2009_2019_icd10,
                       OUT     = sktemp.dgns_2009_2019_icd10_elix,
                       dx      = DGNS_CD01-DGNS_CD10,
                       dxtype  = ,
                       type    = off, 
                       debug   = off);	

proc freq data = sktemp.dgns_2009_2018_icd10_elix;
   title1  "Summary of Elixhauser Comorbidity Groups - ICD-10";
   tables  ELX_GRP: TOT_GRP;
run;

*Combine cohort of ICD-9 with cohort of ICD-10;
data sktemp.elixhauser_2009_2019 (drop=i);
	set sktemp.dgns_2009_2019_icd9_elix  
		sktemp.dgns_2009_2019_icd10_elix; 
run; 