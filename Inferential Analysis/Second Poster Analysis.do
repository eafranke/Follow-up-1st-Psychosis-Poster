********************************* LOAD DF *********************************

* Set working directory
cd "C:\Users\coule\OneDrive - Bentley University\Chow\HMSFirst\Inferential Analysis"

* Load final processed date frame with computed variables
use "FinalCrossSection-3-6-25.dta", clear

* Load unprocessed CSV data frame
* RUN "Variable Pre-processing" DO FILE BEFORE CONDUCTING TESTS
* import delimited "1_to_36_filtered.csv", bindquote(strict) varnames(1) case(preserve) clear



********************************* OVERALL TESTS *********************************


********************************* Fisher's Exact Tests *********************************

* Run Fisher's Exact Test for inpatient_visit by Race/Ethnicity
tab inpatient_visit race_adjusted, exact

* Run Fisher's Exact Test for ed_visit by Race/Ethnicity
tab ed_visit race_adjusted, exact

* Run Fisher's Exact Test for BH_Outpatient by Race/Ethnicity
tab BH_Outpatient race_adjusted, exact


**************************** Kruskal-Wallis & Dunn's Tests ****************************

* Run K-Wallis & Dunn's Test with Bonferroni Correction on BH_Outpatient_fq
dunntest BH_Outpatient_fq, by(race_encoded) ma(bonferroni)

* Run K-Wallis & Dunn's Test with Bonferroni Correction on NonBH_Outpatient_fq
dunntest NonBH_Outpatient_fq, by(race_encoded) ma(bonferroni)



********************************* PRE VS DURING COVID TESTS *********************************


********************************* Chi2 Tests *********************************

* Define a macro holding the list of binary variables
local varlist inpatient_visit ed_visit BH_Outpatient

* Run Chi2 Test for each variable by Pre/During COVID
foreach var of local varlist {
    tab `var' covid, chi2
}


********************************* Mann-Whitney Tests *********************************

* Define a macro holding the list of continuous variables
local varlist BH_Outpatient_fq NonBH_Outpatient_fq

* Run Mann-Whitney Test for each variable by Pre/During COVID
foreach var of local varlist {
    ranksum `var', by(covid) exact
}



********************************* PRE COVID TESTS *********************************


********************************* Fisher's Exact Tests *********************************

* Run Fisher's Exact Test for inpatient_visit by Race/Ethnicity Pre-COVID
tab inpatient_visit race_adjusted if covid == 0, exact

* Run Fisher's Exact Test for ed_visit by Race/Ethnicity Pre-COVID
tab ed_visit race_adjusted if covid == 0, exact

* Run Fisher's Exact Test for BH_Outpatient by Race/Ethnicity Pre-COVID
tab BH_Outpatient race_adjusted if covid == 0, exact


**************************** Kruskal-Wallis & Dunn's Tests ****************************

* Run K-Wallis & Dunn's Test with Bonferroni Correction on BH_Outpatient_fq
dunntest BH_Outpatient_fq if covid == 0, by(race_encoded) ma(bonferroni)

* Run K-Wallis & Dunn's Test with Bonferroni Correction on NonBH_Outpatient_fq
dunntest NonBH_Outpatient_fq if covid == 0, by(race_encoded) ma(bonferroni)




********************************* DURING COVID TESTS *********************************


********************************* Fisher's Exact Tests *********************************

* Run Fisher's Exact Test for inpatient_visit by Race/Ethnicity During-COVID
tab inpatient_visit race_adjusted if covid == 1, exact

* Run Fisher's Exact Test for ed_visit by Race/Ethnicity During-COVID
tab ed_visit race_adjusted if covid == 1, exact

* Run Fisher's Exact Test for BH_Outpatient by Race/Ethnicity During-COVID
tab BH_Outpatient race_adjusted if covid == 1, exact


**************************** Kruskal-Wallis & Dunn's Tests ****************************

* Run K-Wallis & Dunn's Test with Bonferroni Correction on BH_Outpatient_fq
dunntest BH_Outpatient_fq if covid == 1, by(race_encoded) ma(bonferroni)

* Run K-Wallis & Dunn's Test with Bonferroni Correction on NonBH_Outpatient_fq
dunntest NonBH_Outpatient_fq if covid == 1, by(race_encoded) ma(bonferroni)



********************************* PAIRWISE Fisher's Exact Tests Post-hoc *********************************


********************************* OVERALL TESTS *********************************

* Post-hoc on inpatient visits with Fisher's exact test with White reference (Overall Fisher P-value = 0.032)
tab inpatient_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Asian", exact
tab inpatient_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Black", exact
tab inpatient_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Hispanic", exact
tab inpatient_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Other/Unknown", exact
tab inpatient_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Portuguese", exact

* Post-hoc on emergency department visits with Fisher's exact test with White reference (Overall Fisher P-value = 0.043)
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Asian", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Black", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Hispanic", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Other/Unknown", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Portuguese", exact

* Post-hoc Fisher's exact tests for BH Outpatient visits (Overall Fisher P-value = 0.006)
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Asian", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Black", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Hispanic", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Other/Unknown", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Portuguese", exact


********************************* PRE COVID TESTS *********************************

* Post-hoc on emergency department visits with Fisher's exact test with White reference (Overall Fisher P-value = 0.043)
preserve
keep if covid == 0
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Asian", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Black", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Hispanic", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Other/Unknown", exact
tab ed_visit race_adjusted if race_adjusted == "White" | race_adjusted == "Portuguese", exact
restore


********************************* DURING COVID TESTS *********************************

* Post-hoc on BH Outpatient visits with Fisher's exact test with White reference (Overall Fisher P-value = 0.032)
preserve
keep if covid == 1
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Asian", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Black", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Hispanic", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Other/Unknown", exact
tab BH_Outpatient race_adjusted if race_adjusted == "White" | race_adjusted == "Portuguese", exact
restore