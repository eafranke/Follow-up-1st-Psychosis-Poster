# What Happened to Patients 36 Months Following a First Hospitalization for Psychosis at Cambridge Health Alliance? (1/1/2019–12/31/2023)

## About

This repository contains documentation and analysis for a longitudinal research project examining outcomes for patients following their first hospitalization for psychosis at Cambridge Health Alliance (CHA), a safety-net health system serving patients regardless of ability to pay. Historically, a first psychotic episode was viewed as a predictor of lifelong schizophrenia and disability. However, early detection and access to evidence-based psychosocial and pharmacologic treatments—such as those offered through Coordinated Specialty Care (CSC) programs like RISE—may alter the course of illness.

The study investigates racial and ethnic disparities in access to high-quality follow-up care and long-term outcomes, including rehospitalization and emergency service use, up to three years after initial hospitalization. This work was conducted in collaboration with Harvard Medical School faculty and funded by the National Institute of Mental Health (NIMH) and McLean Hospital.

## Research Objectives

- Assess whether patients hospitalized for First Episode Psychosis (FEP) received appropriate follow-up care, such as CSC services.
- Evaluate long-term outcomes, including emergency department visits and rehospitalizations, up to 36 months post-discharge.
- Identify differences in baseline characteristics and outcomes by race and ethnicity.
- Compare patients hospitalized before COVID-19 (Jan 2019–Feb 2020) to those hospitalized during the pandemic (Mar 2020–Dec 2020).

## Hypotheses

1. Baseline characteristics and treatment pathways differ by race and ethnicity.  
2. Patients first hospitalized during the COVID-19 pandemic experienced different outcomes compared to those who entered care pre-COVID.

## Repository Contents

- **Follow-up 36 Months Post-First Hospitalization for Psychosis.pdf**  
  Final research poster summarizing study background, methodology, results, and implications.

- **`Data Prep/`**  
  Scripts for cleaning and merging datasets across the 36-month follow-up period:
  - `1 to 36 Filter.py` – Filters patient records based on 36-month follow-up windows.
  - `Encounter Months.py` – Calculates encounter-based metrics by month after discharge.
  - `First & 275 Merge.R` – Merges initial hospitalization data with longitudinal follow-up records.

- **`Inferential Analysis/`**  
  Stata `.do` files for variable construction and statistical modeling:
  - `Variable Pre-processing.do` – Prepares variables for analysis, including transformations and missingness handling.
  - `Outpatient SS.do` – Analyzes outpatient service utilization across the follow-up period.
  - `Second Poster Analysis.do` – Main inferential analysis script generating results for the poster.

## Data Availability

Due to the presence of sensitive health information, the datasets used in this analysis are not publicly available.

## Contact

**Erik Franke**  
efranke@falcon.bentley.edu  
Bentley University Academic Technology Center | Research Assistant
