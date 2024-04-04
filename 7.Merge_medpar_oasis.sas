/****************************************************************************
***Step 7: Merge MedPAR with OASIS 
****************************************************************************/
/***************************************************************************
***Merge MedPAR 2010-2019 with OASIS admission assessments
****************************************************************************/
proc sql;
	create table oatemp.medpar_oasis_adm as
	select medpar.*, oasis.*, 
		max(soc_date, roc_date) as index_date,
		(calculated index_date - medpar.DSCHRGDT) as gap
	from sktemp.Merged2010_2019_final as medpar
		join oadat.oasis_2010_2019(drop = STATE_CD) as oasis 
			on medpar.BENE_ID = oasis.BENE_ID
			and 
			medpar.DSCHRGDT <= max(soc_date, roc_date) <= medpar.DSCHRGDT + 14
	where M0100_RSN_FOR_ASMT_CD in ("01","02","03")
	order by obs_id, index_date, assess_date,  HHA_ASMT_ID;
quit; 

*Make sure one MedPAR discharge gets linked to only one SOC/ROC date;
*If multiple SOC/ROC within 14 days then use the earlier date;
data oatemp.oasis_adm;
	set oatemp.medpar_oasis_adm;
	by obs_id;
	if first.obs_id;
run;

*Link discharge assessments using admission assessment SOC date;
*Scenario where discharge assessments can be duplicated -;
*Multiple SOC/ROC admission assessments, all linked to different MedPAR discharges -;
*which share the same discharge assessment because their SOC date are the same;

proc sql;
	create table oatemp.medpar_oasis_dischg as
	select a.*, b.*
	from oatemp.oasis_adm (keep = bene_id--dual_eligible soc_date) as a 
		join oadat.oasis_2010_2019 (drop = STATE_CD rename = (soc_date = soc_disch bene_id = bene_id_disch)) as b
			on a.bene_id = b.bene_id_disch and a.soc_date = b.soc_disch
	where b.M0100_RSN_FOR_ASMT_CD in ("09", "10")
	order by obs_id, soc_date, assess_date DESC, HHA_ASMT_ID;
	
	select count(*) as n, count(distinct obs_id) as n_dischg,
			count(distinct HHA_ASMT_ID), count(distinct bene_id) as n_bene
	from oatemp.medpar_oasis_dischg;
quit;

*Keep the last discharge assessment if mutltiple ones;
data oatemp.oasis_dischg;
	set oatemp.medpar_oasis_dischg (drop = soc_disch bene_id_disch);
	by obs_id;
	if first.obs_id;
run;  
 
*Concatenate admission and discharge assessments;
data oatemp.oasis_merged;
	set oatemp.oasis_adm
		oatemp.oasis_dischg;
run;  