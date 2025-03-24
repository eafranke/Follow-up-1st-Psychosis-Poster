************************** Generate Clean RISE Variable: Ref_Rise_Rev **************************
gen Ref_Rise_Rev = . 
replace Ref_Rise_Rev = 0 if strpos(lower(trim(ref_to_RISE)), lower("no")) > 0 
replace Ref_Rise_Rev = 1 if strpos(lower(trim(ref_to_RISE)), lower("yes")) > 0

* Manual adjustements: replace Ref_Rise_Rev = 1 in 223 (1 real change made) replace Ref_Rise_Rev = 1 in 103 (1 real change made) replace Ref_Rise_Rev = 1 in 7 (1 real change made) replace Ref_Rise_Rev = 0 in 79 (1 real change made)


************************** Encode race_adjusted for Dunn's Test **************************

encode race_adjusted, gen(race_encoded)


************************** Generate pre/during Covid Variable **************************

* Convert HOSP_DISCH_TIME to a Stata date format
gen discharge = date(substr(HOSP_DISCH_TIME, 1, 10), "YMD")  // Extracts the date part
format discharge %td

* Generate covid dummy
gen covid = (discharge >= date("01mar2020", "DMY"))


************************** Generate BH_Outpatient Binary Variable **************************

* Fill missing for binary BH variables of interest
replace Any_PSYCH_EandMCpt = 0 if missing(Any_PSYCH_EandMCpt)
replace Any_PSYCH_OtherPsyTrtCpt = 0 if missing(Any_PSYCH_OtherPsyTrtCpt)
replace Any_PSYCH_PsychoTherapyCpt = 0 if missing(Any_PSYCH_PsychoTherapyCpt)
replace anyEncPsychOfficeVisits = 0 if missing(anyEncPsychOfficeVisits)
replace anyEncPsychOtherEncounters = 0 if missing(anyEncPsychOtherEncounters)

* Generate the BH_Outpatient variable
gen BH_Outpatient = (Any_PSYCH_EandMCpt > 0 | ///
                     Any_PSYCH_OtherPsyTrtCpt > 0 | ///
                     Any_PSYCH_PsychoTherapyCpt > 0 | ///
                     anyEncPsychOfficeVisits > 0 | ///
                     anyEncPsychOtherEncounters > 0)
			

************************** Generate Continuous Outpatient Visits Variables **************************

* Define the 95th percentiles of Outpatient Variables
local BH_95 = 80
local NonBH_95 = 3

* Generate BH_Outpatient_fq with the condition
gen BH_Outpatient_fq = cond(clm_fq_svc_BH_outpatient <= `BH_95', max(clm_fq_svc_BH_outpatient, svc_BH_outpatient), svc_BH_outpatient)

* Generate NonBH_Outpatient_fq with the condition
gen NonBH_Outpatient_fq = cond(clm_fq_svc_Outpatient <= `NonBH_95', max(clm_fq_svc_Outpatient, svc_outpatient), svc_outpatient)


************************** Generate Emergency Department Visits Variable **************************

* 0 fill missing values for ED variables
replace anysvc_ED = 0 if missing(anysvc_ED)
replace svc_ED = 0 if missing(svc_ED)
replace clm_fq_svc_ED = 0 if missing(clm_fq_svc_ED)

* Create binary variable for ED Visits
gen ed_visit = 0 
replace ed_visit = 1 if anysvc_ED > 0 | svc_ED > 0 | clm_fq_svc_ED > 0


************************** Generate Inpatient Visits Variable **************************

* 0 fill missing values for inpatient visit variables and recode svc_inpatient
replace anysvc_inpatient = 0 if missing(anysvc_inpatient)
replace anysvc_BH_inpatient = 0 if missing(anysvc_BH_inpatient)
replace svc_BH_inpatient = 0 if missing(svc_BH_inpatient)
gen svc_inpatient_recode = (svc_inpatient == "True")
replace clm_fq_svc_BH_inpatient = 0 if missing(clm_fq_svc_BH_inpatient)
replace clm_fq_svc_inpatient = 0 if missing(clm_fq_svc_inpatient)

* Create binary variable for inpatient visits
gen inpatient_visit = 0
replace inpatient_visit = 1 if anysvc_inpatient > 0 | anysvc_BH_inpatient > 0 | svc_BH_inpatient > 0 | svc_inpatient_recode > 0 | clm_fq_svc_BH_inpatient > 0 | clm_fq_svc_inpatient > 0
