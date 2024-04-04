/*******************************************************************************
***Step 3. Clean participating time period for BPCI data
*******************************************************************************/
data oadat.bpci_enroll_final;
	set bpci.bpci_enroll_all_13_17_w_drg
		(keep = CCN participant_name yr_qtr episodes drg);
	year = input(substr(yr_qtr, 1, 4), 4.);
	qtr = input(substr(yr_qtr, 6, 1), 1.);
	
	if qtr = 1 then do;
		start_date = mdy(1, 1, year);
		end_date = mdy(3, 31, year);
	end;
	
	else if qtr = 2 then do;
		start_date = mdy(4, 1, year);
		end_date = mdy(6, 30, year);
	end;
	
	else if qtr = 3 then do;
		start_date = mdy(7, 1, year);
		end_date = mdy(9, 30, year);
	end;
	
	else if qtr = 4 then do;
		start_date = mdy(10, 1, year);
		end_date = mdy(12, 31, year);
	end;
	
	bpci_ind = 1;

run;

proc sort data = oadat.bpci_enroll_final nodup;
	by _all_;
run;

*Keep only those with BPCI indicator
data oadat.bpci_ever_participated
	set oadat.bpci_enroll_final;
	if bpci_ind=1 then output; 
run;

*Drop duplicates in CCN and create a variable that indicates the provider ever participated in bpci
proc sort data = oadat.bpci_ever_participated out = oadat.bpci_ever_participated nodupkey;
	by CCN; 
run;

data oadat.bpci_ever_participated; 
	set oadat.bpci_ever_participated;
	bpci_ever_participated=1; 
run;

/*******************************************************************************
***Change CJR MSA Participant list to SAS 
*******************************************************************************/
PROC IMPORT file = "/project/pac_caregiving/BPCI/CJR_MSA.xlsx"
	OUT = oadat.cjr_participant_final
	dbms=xlsx
	replace; 
run; 

*Add indicator for MSA_196_list
data oadat.cjr_participant_final; 
	set oadat.cjr_participant_final;
	MSA_196_list=1; 
run; 

/*******************************************************************************
*** Change PRVDR_NUM - MSA crosswalk to SAS 
*******************************************************************************/
PROC IMPORT file = "/project/pac_caregiving/nhats_sk_workspace/output/pos1019.dta"
	OUT = oadat.provider_number_msa_crosswalk
	dbms=dta; 
run; 

*Drop variables that are not needed 

data oadat.provider_number_msa_crosswalk; 
	set oadat.provider_number_msa_crosswalk (drop = STATE_CD SSA_STATE_CD); 
run; 

data oadat.provider_number_msa_crosswalk; 
	set oadat.provider_number_msa_crosswalk (rename = (CBSA_CD = MSA)); 
run; 
