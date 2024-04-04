/****************************************************************************
***Step 10: Categorize discharges into SNF, Home Health, Home without Home Health 
****************************************************************************/
/*************************************************************************************
*** Read MedPAR 2010-2019 to get other claim, discharge to SNF and discharge to other
**************************************************************************************/
data sktemp.medpar2010;
	set Medpar.Mp100mod_2010;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2011;
	set Medpar.Mp100mod_2011;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2012;
	set Medpar.Mp100mod_2012;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2013;
	set Medpar.Mp100mod_2013;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2014;
	set Medpar.Mp100mod_2014;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2015;
	set Medpar.Mp100mod_2015;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2016;
	set Medpar.Mp100mod_2016;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2017;
	set Medpar.Mp100mod_2017;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2018;
	set Medpar.Mp100mod_2018;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 

data sktemp.medpar2019;
	set Medpar.Mp100mod_2019;
	if substr(PRVDR_NUM,3,1) in ('5', '6', 'U', 'W', 'Y', 'Z') then type=1;
	else type=2;
	keep BENE_ID ADMSNDT DSCHRGDT PRVDR_NUM PMT_AMT type UTIL_DAY medpar_id;
run; 


proc sql; 
create table sktemp.medpar2010_2019_snf_other as
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type
from sktemp.medpar2010 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type 
from sktemp.medpar2011 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type
from sktemp.medpar2012 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type
from sktemp.medpar2013 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type 
from sktemp.medpar2014 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type
from sktemp.medpar2015 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type 
from sktemp.medpar2016 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type
from sktemp.medpar2017 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type 
from sktemp.medpar2018 union all
select BENE_ID, ADMSNDT as ADMSNDT_snf_other, DSCHRGDT as DSCHRGDT_snf_other, PRVDR_NUM as snf_other_PRVDRNUM, type
from sktemp.medpar2019; 
quit; 


proc sort data=sktemp.medpar2010_2019_snf_other; 
by BENE_ID ADMSNDT_snf_other; 
run; 

data sktemp.medpar10_19_snf_other_unique;
set sktemp.medpar2010_2019_snf_other;
by BENE_ID ADMSNDT_snf_other;
if first.ADMSNDT_snf_other then output;
run;

data sktemp.medpar10_19_snf_other_unique;
	set sktemp.medpar10_19_snf_other_unique;
	format ADMSNDT_snf_other date9.;
run;

/*************************************************************************************
***Merge cohort A with cohort B, C 
*************************************************************************************/

proc sql;
	create table oatemp.cohort_A_B_C as 
	select a.*, b.*
	from sktemp.Merged2010_2019_final as a 
		left join 
		oatemp.cohort_B_C_20220826 as b
			on a.obs_id= b.obs_id;
quit;

/*************************************************************************************
***Merge with Cohort A data excluding those that received home health 
*************************************************************************************/


*Keep only those that did not received home health 
data sktemp.medpar_oasis_master_data_2;
	set oatemp.cohort_A_B_C;
	IF RECEIVE_HOME_HEALTH=. then output;
run;

*Merge master data with the entire MedPAR data to identify those that went to SNF vs home without home health
proc sql;
	create table sktemp.medpar_oasis_master_data_3 as 
	select a.*, b.*
	from sktemp.medpar_oasis_master_data_2 as a 
		left join 
		sktemp.medpar10_19_snf_other_unique as b 
			on a.BENE_ID = b.BENE_ID 
				and a.DSCHRGDT <= b.ADMSNDT_snf_other <= a.DSCHRGDT+3;
quit; 

*Handle duplicates in the data 
data sktemp.medpar_oasis_master_data_3;
set sktemp.medpar_oasis_master_data_3; 
gap_snf_other=ADMSNDT_snf_other-DSCHRGDT; 
run;

proc sort data=sktemp.medpar_oasis_master_data_3; 
by BENE_ID DSCHRGDT gap_snf_other; run;

data sktemp.medpar_oasis_master_data_4;
set sktemp.medpar_oasis_master_data_3;
by BENE_ID DSCHRGDT gap_snf_other;
if first.DSCHRGDT then output;
run;

/*************************************************************************************
*Merge back to Cohort A,B,C data 
************************************************************************************/

proc sql;
	create table oatemp.cohort_A_B_C_08262022 as 
	select a.*, b. obs_id, b.TYPE
	from oatemp.cohort_A_B_C as a 
		left join 
		sktemp.medpar_oasis_master_data_4 as b
			on a.obs_id= b.obs_id;
quit;


proc export data=oatemp.cohort_A_B_C_08262022 
dbms=dta outfile="/project/pac_caregiving/oasis_sk_workspace/output/cohort_A_B_C_08262022.dta" replace;
run;
