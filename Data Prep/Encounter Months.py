"""
This program calculates the month since discharge a patient receives any service.
"""

import pandas as pd
import os

# Set working directory
os.chdir(r"C:\Users\coule\OneDrive - Bentley University\Chow\HMS\Merge")

# Load the dataset
df = pd.read_csv("HMS Merged.csv", dtype={"HOSP_DISCH_TIME": str, "monthD": str}, low_memory=False)

# Convert HOSP_DISCH_TIME to datetime (automatically infer format)
df["HOSP_DISCH_TIME"] = pd.to_datetime(df["HOSP_DISCH_TIME"])

# Convert monthD to datetime
df["monthD"] = pd.to_datetime(df["monthD"], format="%d%b%Y", errors="coerce")  # Handle potential format issues

# Drop rows where monthD conversion failed
df = df.dropna(subset=["monthD"])

# Calculate the difference in months and create a new column EncMonthSinceDisch
df["EncMonthSinceDisch"] = ((df["monthD"].dt.year - df["HOSP_DISCH_TIME"].dt.year) * 12 +
                            (df["monthD"].dt.month - df["HOSP_DISCH_TIME"].dt.month))

# Drop rows where EncMonthSinceDisch is less than 0
df = df[df["EncMonthSinceDisch"] >= 0]

# Move specified columns to the front, keeping all other columns
columns_to_front = ["PAT_MRN_ID", "HOSP_DISCH_TIME", "monthD", "EncMonthSinceDisch"]
df = df[columns_to_front + [col for col in df.columns if col not in columns_to_front]]

# Save the updated file with the cleaned data
df.to_csv("HMS Merged Encounters Cleaned.csv", index=False)

print("✅ The cleaned dataset 'HMS Merged Encounters Cleaned.csv' has been created with specified columns moved to the front.")
