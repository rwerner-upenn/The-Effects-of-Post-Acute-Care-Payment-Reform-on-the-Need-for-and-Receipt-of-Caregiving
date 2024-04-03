/****************************************************************************
***Step 1: Clean up OASIS 
*****************************************************************************

/****************************************************************************
***Read in OASIS data 2010-2019
*****************************************************************************/

*2010 - 2014
%macro imp(yr, year, filenm);

data oatemp.oasis&yr.;
	set OASIS.&filenm. 
	(keep = HHA_ASMT_ID RSDNT_INTRNL_ID STATE_CD M0010_CMS_CRTFCTN_NUM
			M0100_RSN_FOR_ASMT_CD
			M0030_STRT_CARE_DT M0032_ROC_DT M0032_ROC_NA_TXT 
			M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT
			M2100: M2110:
			M1700_CGNTV_FNCTN_CD M1900:
			M1830_BATHG_CD
			M1810_DRESS_UPR_CD
			M1820_DRESS_LWR_CD
			M1845_TOILT_HYGNE_CD
			M1840_TOILT_TRNSFR_CD
			M1850_TRNSFRG_CD
			M1870_EATG_CD
			M1610_URNRY_INCNTNC_CD
			M1620_BWL_INCNTNC_FREQ_CD
			M1860_AMBLTN_CD
			M1880_PREP_MEAL_CD
			M1890_TEL_CD
			M0150_MDCD_FFS_PMT_CD
			M0150_MDCR_FFS_PMT_CD
			M0140_AMRCN_INDN_AK_NTV_CD
			M0140_ASN_CD 
			M0140_AFRCN_AMRCN_CD
			M0140_HSPNC_CD 
			M0140_NTV_HI_PCFC_ISLNDR_CD
			M0140_WHT_CD

	rename = (M1830_BATHG_CD = M1830 
				M1810_DRESS_UPR_CD = M1810
				M1820_DRESS_LWR_CD = M1820
				M1845_TOILT_HYGNE_CD = M1845
				M1840_TOILT_TRNSFR_CD = M1840
				M1850_TRNSFRG_CD = M1850
				M1870_EATG_CD=M1870 
				M1610_URNRY_INCNTNC_CD=M1610 
				M1620_BWL_INCNTNC_FREQ_CD=M1620 
				M1860_AMBLTN_CD=M1860
				M1880_PREP_MEAL_CD=M1880
				M1890_TEL_CD=M1890));
		
	oasis_year = &year.;
			
	soc_date = input(M0030_STRT_CARE_DT, yymmdd10.);
	roc_na = input(M0032_ROC_NA_TXT, 1.);
	if roc_na = 1 then roc_date = .;
		else roc_date = input(M0032_ROC_DT, yymmdd10.);
	dschrg_death_date = input(M0906_DSCHRG_DEATH_DT,yymmdd10.);
	assess_date = input(M0090_ASMT_CMPLT_DT, yymmdd10.);
	
	M2100_ADL = 	input(M2100_ADL_ASTNC_CD, 2.);
	M2100_ADVCY =	input(M2100_ADVCY_ASTNC_CD, 2.);
	M2100_IADL = 	input(M2100_IADL_ASTNC_CD, 2.);
	M2100_EQUIP = 	input(M2100_EQUIP_ASTNC_CD, 2.);
	M2100_PRCDR = 	input(M2100_PRCDR_ASTNC_CD, 2.);
	M2100_MDCTN = 	input(M2100_MDCTN_ASTNC_CD, 2.);
	M2100_SFTY = 	input(M2100_SFTY_ASTNC_CD, 2.);
	
	M1700_CGNTV = 	input(M1700_CGNTV_FNCTN_CD, 2.);
	M1900_AMB = 	input(M1900_PRIOR_AMBLTN_CD, 2.);
	M1900_HSH = 	input(M1900_PRIOR_HSEHLD_TASK_CD, 2.);
	M1900_SEL = 	input(M1900_PRIOR_SELF_CARE_CD, 2.);
	M1900_TRN = 	input(M1900_PRIOR_TRNSFR_CD, 2.);
	
	if M2110_ADL_IADL_ASTNC_FREQ_CD = "UK" then M2110_ADL_IADL_FREQ = -1;
		else M2110_ADL_IADL_FREQ = input(M2110_ADL_IADL_ASTNC_FREQ_CD, 2.);
	
	drop M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT
		M2110_ADL_IADL_ASTNC_FREQ_CD
		M1700_CGNTV_FNCTN_CD
		M1900_PRIOR:;
run;

proc sort data = oatemp.oasis&yr.; by RSDNT_INTRNL_ID STATE_CD; run;

%mend imp;
%imp(10, 2010, HHA_RAW_28557_2010)
%imp(11, 2011, HHA_RAW_28557_2011)
%imp(12, 2012, HHA_RAW_28557_2012)
%imp(13, 2013,  HHA_RAW_28557_2013)
%imp(14a, 2014, oasis28557_jan_jun_2014)
%imp(14b, 2014, oasis28557_jul_dec_2014)


*2015 - 2016
%macro imp(yr, year, filenm);

data oatemp.oasis&yr.;
	set OASIS.&filenm. 
	(keep = HHA_ASMT_ID RSDNT_INTRNL_ID STATE_CD M0010_CMS_CRTFCTN_NUM
			M0100_RSN_FOR_ASMT_CD
			M0030_STRT_CARE_DT M0032_ROC_DT M0032_ROC_NA_TXT 
			M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT
			M2102: M2110:
			M1700_CGNTV_FNCTN_CD M1900:
			M1830_BATHG_CD
			M1810_DRESS_UPR_CD
			M1820_DRESS_LWR_CD
			M1845_TOILT_HYGNE_CD
			M1840_TOILT_TRNSFR_CD
			M1850_TRNSFRG_CD
			M1870_EATG_CD
			M1610_URNRY_INCNTNC_CD
			M1620_BWL_INCNTNC_FREQ_CD
			M1860_AMBLTN_CD
			M1880_PREP_MEAL_CD
			M1890_TEL_CD
			M0150_MDCD_FFS_PMT_CD
			M0150_MDCR_FFS_PMT_CD
			M0140_AMRCN_INDN_AK_NTV_CD
			M0140_ASN_CD 
			M0140_AFRCN_AMRCN_CD
			M0140_HSPNC_CD 
			M0140_NTV_HI_PCFC_ISLNDR_CD
			M0140_WHT_CD

	rename = (M1830_BATHG_CD = M1830 
				M1810_DRESS_UPR_CD = M1810
				M1820_DRESS_LWR_CD = M1820
				M1845_TOILT_HYGNE_CD = M1845
				M1840_TOILT_TRNSFR_CD = M1840
				M1850_TRNSFRG_CD = M1850
				M1870_EATG_CD=M1870 
				M1610_URNRY_INCNTNC_CD=M1610 
				M1620_BWL_INCNTNC_FREQ_CD=M1620 
				M1860_AMBLTN_CD=M1860
				M1880_PREP_MEAL_CD=M1880
				M1890_TEL_CD=M1890));
			
	oasis_year = &year.;
			
	soc_date = input(M0030_STRT_CARE_DT, yymmdd10.);
	roc_na = input(M0032_ROC_NA_TXT, 1.);
	if roc_na = 1 then roc_date = .;
		else roc_date = input(M0032_ROC_DT, yymmdd10.);
	dschrg_death_date = input(M0906_DSCHRG_DEATH_DT,yymmdd10.);
	assess_date = input(M0090_ASMT_CMPLT_DT, yymmdd10.);
	
	M2100_ADL = 	input(M2102_CARE_ASTNC_ADL_CD, 2.);
	M2100_ADVCY =	input(M2102_CARE_ASTNC_ADVCY_CD, 2.);
	M2100_IADL = 	input(M2102_CARE_ASTNC_IADL_CD, 2.);
	M2100_EQUIP = 	input(M2102_CARE_ASTNC_EQUIP_CD, 2.);
	M2100_PRCDR = 	input(M2102_CARE_ASTNC_PRCDR_CD, 2.);
	M2100_MDCTN = 	input(M2102_CARE_ASTNC_MDCTN_CD, 2.);
	M2100_SFTY = 	input(M2102_CARE_ASTNC_SFTY_CD, 2.);
	
	M1700_CGNTV = 	input(M1700_CGNTV_FNCTN_CD, 2.);
	M1900_AMB = 	input(M1900_PRIOR_AMBLTN_CD, 2.);
	M1900_HSH = 	input(M1900_PRIOR_HSEHLD_TASK_CD, 2.);
	M1900_SEL = 	input(M1900_PRIOR_SELF_CARE_CD, 2.);
	M1900_TRN = 	input(M1900_PRIOR_TRNSFR_CD, 2.);
	
	if M2110_ADL_IADL_ASTNC_FREQ_CD = "UK" then M2110_ADL_IADL_FREQ = -1;
		else M2110_ADL_IADL_FREQ = input(M2110_ADL_IADL_ASTNC_FREQ_CD, 2.);
	
	drop  M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT
		M2110_ADL_IADL_ASTNC_FREQ_CD
		M1700_CGNTV_FNCTN_CD
		M1900_PRIOR:;
run;

proc sort data = oatemp.oasis&yr.; by RSDNT_INTRNL_ID STATE_CD; run;

%mend imp;
%imp(15, 2015, HHA_RAW_51953_2015)
%imp(16, 2016, HHA_RAW_51953_2016)

*2017 - 2018
%macro imp(yr, year, filenm);

data oatemp.oasis&yr.;
	set OASIS.&filenm. 
	(keep = HHA_ASMT_ID_3 RSDNT_INTRNL_ID_3 RSDNT_STATE_CD PRVDR_ASMT_CCN_5
			HHA_RSN_FOR_ASMT_CD_18
			CLNDR_CARE_STRT_DT_SK CLNDR_CARE_RSMPTN_DT_SK RSMPTN_OF_CARE_DT_NA_SW
			CLNDR_DSCHRG_DEATH_DT_SK_3 CLNDR_ASMT_RFRNC_DT_SK_15
			ADL_CARE_ASTNC_CD
			ADVCY_CARE_ASTNC_CD
			IADL_CARE_ASTNC_CD
			EQUIP_CARE_ASTNC_CD
			PRCDRS_CARE_ASTNC_CD
			MDCTN_CARE_ASTNC_CD
			SFTY_CARE_ASTNC_CD
			ADL_IADL_ASTNC_FREQ_CD
			CGNTV_FNCTN_CD
			PRIOR_AMBLTN_CD_5
			PRIOR_HSEHLD_TSK_CD
			PRIOR_SELF_CARE_CD
			TRNSFR_SELF_CD_4
			BATHG_SELF_CD_4
			HHA_DRSNG_UPR_ADMSN_CD
			HHA_DRSNG_LWR_ADMSN_CD
			TOILT_HYGN_CD
			TOILTG_SELF_CD_4
			TRNSFR_CD_5
			EATG_SELF_CD_4
			URNRY_INCNTNC_CD_5
			BWL_INCNTNC_FREQ_CD
			AMBLTN_CD_1
			PREP_FOOD_CD
			TEL_CD
			MDCD_FFS_PYR_CD_2 
			MDCR_FFS_PYR_CD_2
			AMRCN_INDN_ALSKANTV_ETHNC_CD_3
			ASN_ETHNC_CD_4
			AFRCN_AMRCN_ETHNC_CD_3
			HSPNC_ETHNC_CD_3
			NTV_HWN_PCFC_ISLNDR_ETHNC_CD_4 
			WHT_ETHNC_CD_5

	rename = (HHA_ASMT_ID_3 = HHA_ASMT_ID
			RSDNT_INTRNL_ID_3 = RSDNT_INTRNL_ID
			RSDNT_STATE_CD = STATE_CD
			PRVDR_ASMT_CCN_5 = M0010_CMS_CRTFCTN_NUM
			HHA_RSN_FOR_ASMT_CD_18 = M0100_RSN_FOR_ASMT_CD
			CLNDR_CARE_STRT_DT_SK = M0030_STRT_CARE_DT 
			CLNDR_CARE_RSMPTN_DT_SK = M0032_ROC_DT
			RSMPTN_OF_CARE_DT_NA_SW = M0032_ROC_NA_TXT
			CLNDR_DSCHRG_DEATH_DT_SK_3 = M0906_DSCHRG_DEATH_DT
			CLNDR_ASMT_RFRNC_DT_SK_15 = M0090_ASMT_CMPLT_DT
			ADL_CARE_ASTNC_CD 		= M2102_CARE_ASTNC_ADL_CD
			ADVCY_CARE_ASTNC_CD 	= M2102_CARE_ASTNC_ADVCY_CD
			IADL_CARE_ASTNC_CD		= M2102_CARE_ASTNC_IADL_CD
			EQUIP_CARE_ASTNC_CD 	= M2102_CARE_ASTNC_EQUIP_CD
			PRCDRS_CARE_ASTNC_CD	= M2102_CARE_ASTNC_PRCDR_CD
			MDCTN_CARE_ASTNC_CD 	= M2102_CARE_ASTNC_MDCTN_CD
			SFTY_CARE_ASTNC_CD 		= M2102_CARE_ASTNC_SFTY_CD
			ADL_IADL_ASTNC_FREQ_CD = M2110_ADL_IADL_ASTNC_FREQ_CD
			CGNTV_FNCTN_CD = M1700_CGNTV_FNCTN_CD
			PRIOR_AMBLTN_CD_5 = M1900_PRIOR_AMBLTN_CD
			PRIOR_HSEHLD_TSK_CD = M1900_PRIOR_HSEHLD_TASK_CD
			PRIOR_SELF_CARE_CD = M1900_PRIOR_SELF_CARE_CD
			TRNSFR_SELF_CD_4 = M1900_PRIOR_TRNSFR_CD
			BATHG_SELF_CD_4 			= M1830 
			HHA_DRSNG_UPR_ADMSN_CD 		= M1810
			HHA_DRSNG_LWR_ADMSN_CD 		= M1820
			TOILT_HYGN_CD 	    = M1845
			TOILTG_SELF_CD_4	= M1840
			TRNSFR_CD_5 	    = M1850
			EATG_SELF_CD_4		= M1870 
			URNRY_INCNTNC_CD_5	= M1610 
			BWL_INCNTNC_FREQ_CD	= M1620 
			AMBLTN_CD_1			= M1860
			PREP_FOOD_CD        = M1880
			TEL_CD              = M1890
			MDCD_FFS_PYR_CD_2   = M0150_MDCD_FFS_PMT_CD
			MDCR_FFS_PYR_CD_2   = M0150_MDCR_FFS_PMT_CD
			AMRCN_INDN_ALSKANTV_ETHNC_CD_3 = M0140_AMRCN_INDN_AK_NTV_CD
			ASN_ETHNC_CD_4                 = M0140_ASN_CD
			AFRCN_AMRCN_ETHNC_CD_3         = M0140_AFRCN_AMRCN_CD
			HSPNC_ETHNC_CD_3               = M0140_HSPNC_CD
			NTV_HWN_PCFC_ISLNDR_ETHNC_CD_4 = M0140_NTV_HI_PCFC_ISLNDR_CD
			WHT_ETHNC_CD_5                 = M0140_WHT_CD));
				
	oasis_year = &year.;
			
	soc_date = input(M0030_STRT_CARE_DT, yymmdd10.);
	roc_na = input(M0032_ROC_NA_TXT, 1.);
	if roc_na = 1 then roc_date = .;
		else roc_date = input(M0032_ROC_DT, yymmdd10.);
	dschrg_death_date = input(M0906_DSCHRG_DEATH_DT, yymmdd10.);
	assess_date = input(M0090_ASMT_CMPLT_DT, yymmdd10.);
	
	if M2102_CARE_ASTNC_ADL_CD in ("^") then M2100_ADL = .; 
	else M2100_ADL = 	input(M2102_CARE_ASTNC_ADL_CD, 2.);
	
	if M2102_CARE_ASTNC_ADVCY_CD in ("^") then M2100_ADVCY = .; 
	else M2100_ADVCY =	input(M2102_CARE_ASTNC_ADVCY_CD, 2.);
	
	if M2102_CARE_ASTNC_IADL_CD in ("^") then M2100_IADL = .; 
	else M2100_IADL = 	input(M2102_CARE_ASTNC_IADL_CD, 2.);
	
	if M2102_CARE_ASTNC_EQUIP_CD in ("^") then M2100_EQUIP = . ; 
	else M2100_EQUIP = 	input(M2102_CARE_ASTNC_EQUIP_CD, 2.);
	
	if M2102_CARE_ASTNC_PRCDR_CD in ("^") then M2100_PRCDR = .; 
	else M2100_PRCDR = 	input(M2102_CARE_ASTNC_PRCDR_CD, 2.);
	
	if M2102_CARE_ASTNC_MDCTN_CD in ("^") then M2100_MDCTN = .; 
	else M2100_MDCTN = 	input(M2102_CARE_ASTNC_MDCTN_CD, 2.);
	
	if M2102_CARE_ASTNC_SFTY_CD in ("^") then M2100_SFTY = . ; 
	else M2100_SFTY = 	input(M2102_CARE_ASTNC_SFTY_CD, 2.);
	
	if M1700_CGNTV_FNCTN_CD in ("^") then M1700_CGNTV = . ; 
	else M1700_CGNTV = 	input(M1700_CGNTV_FNCTN_CD, 2.);
	
	if M1900_PRIOR_AMBLTN_CD in ("^") then M1900_AMB = .; 
	else M1900_AMB = 	input(M1900_PRIOR_AMBLTN_CD, 2.);
	
	if M1900_PRIOR_HSEHLD_TASK_CD in ("^") then M1900_HSH = .; 
	else M1900_HSH = 	input(M1900_PRIOR_HSEHLD_TASK_CD, 2.);
	
	if M1900_PRIOR_SELF_CARE_CD in ("^") then M1900_SEL = .; 
	else M1900_SEL = 	input(M1900_PRIOR_SELF_CARE_CD, 2.);
	
	if M1900_PRIOR_TRNSFR_CD in ("^") then M1900_TRN = .; 
	else M1900_TRN = 	input(M1900_PRIOR_TRNSFR_CD, 2.);
	
	if M2110_ADL_IADL_ASTNC_FREQ_CD in ("UK", "^", "99") then M2110_ADL_IADL_FREQ = -1;
		else M2110_ADL_IADL_FREQ = input(M2110_ADL_IADL_ASTNC_FREQ_CD, 2.);
	
	drop M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT
		M2110_ADL_IADL_ASTNC_FREQ_CD
		M1700_CGNTV_FNCTN_CD
		M1900_PRIOR:;
run;

proc sort data = oatemp.oasis&yr.; by RSDNT_INTRNL_ID STATE_CD; run;

%mend imp;
%imp(17a, 2017, OASIS_55070_Q1Q2_2017)
%imp(17b, 2017, OASIS_55070_Q3Q4_2017)
%imp(18a, 2018, OASIS_55070_Q1Q2_2018)
%imp(18b, 2018, OASIS_55070_Q3Q4_2018)

*2019 
%macro imp(yr, year, filenm);

data oatemp.oasis&yr.;
	set OASIS.&filenm. 
	(keep = HHA_ASMT_ID QIES_RSDNT_INTRNL_ID M0050_PTNT_STATE_CD M0010_CMS_CRTFCTN_NUM 
			M0100_RSN_FOR_ASMT_CD 
			M0030_STRT_CARE_DT  M0032_ROC_DT M0032_ROC_NA_TXT 
			M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT 
			M2102_CARE_ASTNC_ADL_CD
			M2102_CARE_ASTNC_ADVCY_CD
			M2102_CARE_ASTNC_IADL_CD
			M2102_CARE_ASTNC_EQUIP_CD 
			M2102_CARE_ASTNC_PRCDR_CD 
			M2102_CARE_ASTNC_MDCTN_CD
			M2102_CARE_ASTNC_SFTY_CD
			M2110_ADL_IADL_ASTNC_FREQ_CD
			M1700_CGNTV_FNCTN_CD 
			M1900_PRIOR_AMBLTN_CD
			M1900_PRIOR_HSEHLD_TASK_CD
			M1900_PRIOR_SELF_CARE_CD
			M1900_PRIOR_TRNSFR_CD
			M1830_BATHG_CD
			M1810_DRESS_UPR_CD
			M1820_DRESS_LWR_CD
			M1845_TOILT_HYGNE_CD
			M1840_TOILT_TRNSFR_CD 
			M1850_TRNSFRG_CD 
			M1870_EATG_CD
			M1610_URNRY_INCNTNC_CD 
			M1620_BWL_INCNTNC_FREQ_CD
			M1860_AMBLTN_CD
			M1880_PREP_MEAL_CD 
			M1890_TEL_CD
			M0150_MDCD_FFS_PMT_CD 
			M0150_MDCR_FFS_PMT_CD
			M0140_AMRCN_INDN_AK_NTV_CD
			M0140_ASN_CD 
			M0140_AFRCN_AMRCN_CD
			M0140_HSPNC_CD 
			M0140_NTV_HI_PCFC_ISLNDR_CD
			M0140_WHT_CD

	rename = (QIES_RSDNT_INTRNL_ID  = RSDNT_INTRNL_ID
			M0050_PTNT_STATE_CD  = STATE_CD
			M1830_BATHG_CD 	   	= M1830 
			M1810_DRESS_UPR_CD 		= M1810
			M1820_DRESS_LWR_CD 		= M1820
			M1845_TOILT_HYGNE_CD	= M1845
			M1840_TOILT_TRNSFR_CD 	= M1840
			M1850_TRNSFRG_CD  		= M1850
			M1870_EATG_CD				=M1870 
			M1610_URNRY_INCNTNC_CD 	=M1610 
			M1620_BWL_INCNTNC_FREQ_CD	=M1620 
			M1860_AMBLTN_CD			= M1860
			M1880_PREP_MEAL_CD =M1880
			M1890_TEL_CD=M1890));
	
	oasis_year = &year.;
			
	soc_date = input(M0030_STRT_CARE_DT, yymmdd10.);
	roc_na = input(M0032_ROC_NA_TXT, 1.);
	if roc_na = 1 then roc_date = .;
		else roc_date = input(M0032_ROC_DT, yymmdd10.);
	dschrg_death_date = input(M0906_DSCHRG_DEATH_DT,yymmdd10.);
	assess_date = input(M0090_ASMT_CMPLT_DT, yymmdd10.);
	
	if M2102_CARE_ASTNC_ADL_CD in ("^") then M2100_ADL = .; 
	else M2100_ADL = 	input(M2102_CARE_ASTNC_ADL_CD, 2.);
	
	if M2102_CARE_ASTNC_ADVCY_CD in ("^") then M2100_ADVCY = .; 
	else M2100_ADVCY =	input(M2102_CARE_ASTNC_ADVCY_CD, 2.);
	
	if M2102_CARE_ASTNC_IADL_CD in ("^") then M2100_IADL = .; 
	else M2100_IADL = 	input(M2102_CARE_ASTNC_IADL_CD, 2.);
	
	if M2102_CARE_ASTNC_EQUIP_CD in ("^") then M2100_EQUIP = . ; 
	else M2100_EQUIP = 	input(M2102_CARE_ASTNC_EQUIP_CD, 2.);
	
	if M2102_CARE_ASTNC_PRCDR_CD in ("^") then M2100_PRCDR = .; 
	else M2100_PRCDR = 	input(M2102_CARE_ASTNC_PRCDR_CD, 2.);
	
	if M2102_CARE_ASTNC_MDCTN_CD in ("^") then M2100_MDCTN = .; 
	else M2100_MDCTN = 	input(M2102_CARE_ASTNC_MDCTN_CD, 2.);
	
	if M2102_CARE_ASTNC_SFTY_CD in ("^") then M2100_SFTY = . ; 
	else M2100_SFTY = 	input(M2102_CARE_ASTNC_SFTY_CD, 2.);
	
	if M1700_CGNTV_FNCTN_CD in ("^") then M1700_CGNTV = . ; 
	else M1700_CGNTV = 	input(M1700_CGNTV_FNCTN_CD, 2.);
	
	if M1900_PRIOR_AMBLTN_CD in ("^") then M1900_AMB = .; 
	else M1900_AMB = 	input(M1900_PRIOR_AMBLTN_CD, 2.);
	
	if M1900_PRIOR_HSEHLD_TASK_CD in ("^") then M1900_HSH = .; 
	else M1900_HSH = 	input(M1900_PRIOR_HSEHLD_TASK_CD, 2.);
	
	if M1900_PRIOR_SELF_CARE_CD in ("^") then M1900_SEL = .; 
	else M1900_SEL = 	input(M1900_PRIOR_SELF_CARE_CD, 2.);
	
	if M1900_PRIOR_TRNSFR_CD in ("^") then M1900_TRN = .; 
	else M1900_TRN = 	input(M1900_PRIOR_TRNSFR_CD, 2.);
	
	if M2110_ADL_IADL_ASTNC_FREQ_CD in ("UK", "^") then M2110_ADL_IADL_FREQ = -1;
		else M2110_ADL_IADL_FREQ = input(M2110_ADL_IADL_ASTNC_FREQ_CD, 2.);
	
	drop M0906_DSCHRG_DEATH_DT M0090_ASMT_CMPLT_DT
		M2110_ADL_IADL_ASTNC_FREQ_CD
		M1700_CGNTV_FNCTN_CD
		M1900_PRIOR:;
run;

proc sort data = oatemp.oasis&yr.; by RSDNT_INTRNL_ID STATE_CD; run;

%mend imp;
%imp(19a, 2019, OASIS_55070_Q1Q2_2019)
%imp(19b, 2019, OASIS_55070_Q3Q4_2019)

/***************************************************************************
***Add Bene_id to OASIS
***************************************************************************/

%macro addid(yr, xwalk, statevar);

proc sql;
	create table oatemp.oasis&yr._beneid as
	select a.*, b.BENE_ID
	from oatemp.oasis&yr. as a join OASIS.&xwalk. as b
		on a.RSDNT_INTRNL_ID = input(b.RES_INT_ID, 12.)
			and a.STATE_CD = b.&statevar.;
			
	select count(distinct HHA_ASMT_ID) as n from oatemp.oasis&yr._beneid;
	select count(distinct BENE_ID) as n from oatemp.oasis&yr._beneid;
quit;

*Delete intermediate datasets to free up space;
proc datasets lib=oatemp nolist;
   delete oasis&yr.;
run;
quit;

%mend addid;
%addid(10, oasis_res_bene_xwalk_1013, STATE_CD)
%addid(11, oasis_res_bene_xwalk_1013, STATE_CD)
%addid(12, oasis_res_bene_xwalk_1013, STATE_CD)
%addid(13, oasis_res_bene_xwalk_1013, STATE_CD)
%addid(14a, oasis_res_bene_xwalk_28557_2014, STATE_ID)
%addid(14b, oasis_res_bene_xwalk_28557_2014, STATE_ID)
%addid(15, oasis_res_bene_xwalk_1516, STATE_ID)
%addid(16, oasis_res_bene_xwalk_1516, STATE_ID)
%addid(17a, oasis_res_bene_xwalk_1718, STATE_ID)
%addid(17b, oasis_res_bene_xwalk_1718, STATE_ID)
%addid(18a, oasis_res_bene_xwalk_1718, STATE_ID)
%addid(18b, oasis_res_bene_xwalk_1718, STATE_ID)
%addid(19a, oasis_res_bene_xwalk_19, STATE_ID)
%addid(19b, oasis_res_bene_xwalk_19, STATE_ID)

/****************************************************************************
*** Combine OASIS 2010-2019
*****************************************************************************/
data oadat.oasis_2010_2019;
	length M0100_RSN_FOR_ASMT_CD $2.;
	set oatemp.oasis10_beneid
		oatemp.oasis11_beneid
		oatemp.oasis12_beneid
		oatemp.oasis13_beneid
		oatemp.oasis14a_beneid
		oatemp.oasis14b_beneid
		oatemp.oasis15_beneid
		oatemp.oasis16_beneid
		oatemp.oasis17a_beneid
		oatemp.oasis17b_beneid
		oatemp.oasis18a_beneid
		oatemp.oasis18b_beneid
		oatemp.oasis19a_beneid
		oatemp.oasis19b_beneid
		;
	if M0100_RSN_FOR_ASMT_CD in ("01","02","03") then assess_type = 1;
		else if M0100_RSN_FOR_ASMT_CD in ("04","05") then assess_type = 2;
		else if M0100_RSN_FOR_ASMT_CD in ("06","07","08","09") then assess_type = 3;

	*ADL variables;
	if M1830 in ('00','01','04') then ADL_bath=0; 
		else if M1830 in ('02','03','05','06') then ADL_bath=1; 
	if M1810 ='00' and M1820 ='00' then ADL_dress=0; 
		else if M1810^=" " and M1820^=" " then ADL_dress=1;
	if M1845 in ('00','01') and M1840 eq '00' then ADL_toilet=0; 
		else if M1840^=" " and M1845^=" " then ADL_toilet=1; 
	if M1850 in ('00','01') then ADL_trans=0; 
		else if M1850 in ('02','03','04','05') then ADL_trans=1; 
	if M1870 in ('00','01','03') then ADL_eating=0; 
		else if M1870 in ('02','04','05') then ADL_eating=1;
	if M1610 in ('00','02') then ADL_uri=0; 
		else if M1610 eq '01' then ADL_uri=2; 
	if M1620 in ('00','UK','NA') then ADL_bwl=0; 
		else if M1620 in ('01','02','03','04','05') then ADL_bwl=1; 
	if ADL_uri=0 and ADL_bwl=0 then ADL_conti=0; 
		else if ADL_uri^=. and ADL_bwl^=. then ADL_conti=1;

	ADL_6_total=sum(ADL_bath, ADL_dress, ADL_trans, ADL_toilet, ADL_eating, ADL_conti);
	if ADL_6_total > 0 then flag_ADL_6_impair = 1; 
	
	ADL_5_total=sum(ADL_bath, ADL_dress, ADL_toilet, ADL_eating, ADL_conti);
	if ADL_5_total > 0 then flag_ADL_5_impair = 1; 
	
	*MADL variables;
	if M1850 eq '00' then MADL_trans=0; 
		else if M1850 in ('01','02') then MADL_trans=1; 
		else if M1850 in ('03','04','05') then MADL_trans=2;
	if M1860 in ('00','01','04') then MADL_ambl=0; 
		else if M1860 in ('02','03') then MADL_ambl=1; 
		else if M1860 in ('05','06') then MADL_ambl=2;
	
	MADL_total=sum(MADL_trans, MADL_ambl);
	if MADL_total > 0 then flag_MADL_impair = 1; 
run;
