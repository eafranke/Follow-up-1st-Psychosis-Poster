************************** BH_Outpatient_fq SS **************************

* Summary Stats for BH Outpatient Visits Overall
tabstat BH_Outpatient_fq, by(race_adjusted) statistics(n mean median sd min max)

* Summary Stats for BH Outpatient Visits Pre-COVID
tabstat BH_Outpatient_fq if covid == 0, by(race_adjusted) statistics(n mean median sd min max)

* Summary Stats for BH Outpatient Visits During-COVID
tabstat BH_Outpatient_fq if covid == 1, by(race_adjusted) statistics(n mean median sd min max)

************************** NonBH_Outpatient_fq SS **************************

* Summary Stats for Non-BH Outpatient Visits Overall
tabstat NonBH_Outpatient_fq, by(race_adjusted) statistics(n mean median sd min max)

* Summary Stats for Non-BH Outpatient Visits Pre-COVID
tabstat NonBH_Outpatient_fq if covid == 0, by(race_adjusted) statistics(n mean median sd min max)

* Summary Stats for Non-BH Outpatient Visits During-COVID
tabstat NonBH_Outpatient_fq if covid == 1, by(race_adjusted) statistics(n mean median sd min max)

tabstat daysenrolled_Commercial, by(race_adjusted) statistics(n mean median sd min max)

tabstat daysenrolled_Medicaid, by(race_adjusted) statistics(n mean median sd min max)

tabstat daysenrolled_Medicare, by(race_adjusted) statistics(n mean median sd min max)

sum daysenrolled_Commercial daysenrolled_Medicaid daysenrolled_Medicare

browse PAT_MRN_ID daysenrolled_Commercial daysenrolled_Medicaid daysenrolled_Medicare