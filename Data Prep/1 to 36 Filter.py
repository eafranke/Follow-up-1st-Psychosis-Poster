import pandas as pd
import os

# Change working directory
os.chdir(r"C:\Users\coule\OneDrive - Bentley University\Chow\HMS\Filter")

# Load CSV with PAT_MRN_ID as a string, while preserving column order
file_path = 'HMS Merged Encounters.csv'
df = pd.read_csv(file_path, dtype={'PAT_MRN_ID': str})  # Ensures PAT_MRN_ID is read as a string

# Store original column order
original_column_order = df.columns.tolist()

# Filter the rows based on 'Encounters since discharge'
filtered_df = df[df['EncMonthSinceDisch'].isin(range(1, 37))]  # More concise way to filter

# Save the filtered DataFrame to a new CSV file
output_path = '1_to_36.csv'
filtered_df.to_csv(output_path, index=False)  # Writing preserves strings

print(f"Filtered data saved to {output_path}")

# Reload the DataFrame, again ensuring PAT_MRN_ID remains a string
df = pd.read_csv('1_to_36.csv', dtype={'PAT_MRN_ID': str})

# Identify numeric columns (where max operation will be applied)
numeric_columns = df.select_dtypes(include='number').columns.tolist()

# Identify non-numeric columns (where the first value will be retained)
non_numeric_columns = [col for col in df.columns if col not in numeric_columns]

# Specify columns to sum instead of taking max
sum_columns = ['clm_fq_svc_BH_outpatient', 'svc_BH_outpatient', 'clm_fq_svc_Outpatient', 'svc_outpatient']
numeric_columns = [col for col in numeric_columns if col not in sum_columns]  # Remove sum columns from max operation

# Group by PAT_MRN_ID and apply appropriate aggregation
df_grouped = df.groupby('PAT_MRN_ID', as_index=False).agg(
    {col: 'sum' for col in sum_columns} |  # Sum specified columns
    {col: 'max' for col in numeric_columns} |  # Max for other numeric columns
    {col: 'first' for col in non_numeric_columns}  # First for non-numeric columns
)

# Reorder columns to match the original order
df_grouped = df_grouped[original_column_order]

# Save the grouped DataFrame, keeping PAT_MRN_ID as a string and maintaining column order
output_path_grouped = '1_to_36_filtered.csv'
df_grouped.to_csv(output_path_grouped, index=False)  # Writing preserves leading zeros

print(f"Grouped data saved to {output_path_grouped}")

# # Below code replaces missing PAT_MRN ID's
#
# # Load the DataFrames
# df_full = pd.read_csv('0_to_1.csv')  # Reference DataFrame with all 275 IDs
# df_current = pd.read_csv('1_to_12_filtered.csv')  # DataFrame to update
#
# # Define the key columns to retain
# retain_columns = ['PAT_MRN_ID', 'Encounters since discharge', 'race_adjusted']
#
# # Identify the missing PAT_MRN_IDs
# missing_ids = set(df_full['PAT_MRN_ID']) - set(df_current['PAT_MRN_ID'])
#
# # Filter rows from 0_to_1.csv corresponding to the missing IDs
# missing_rows = df_full[df_full['PAT_MRN_ID'].isin(missing_ids)].copy()
#
# # Retain only the necessary columns and add missing columns filled with 0
# missing_rows = missing_rows[retain_columns]
#
# # Add zero-filled columns for any remaining columns in 1_to_12.csv
# columns_to_fill = [col for col in df_current.columns if col not in retain_columns]
# for col in columns_to_fill:
#     missing_rows[col] = 0
#
# # Ensure column order matches the original DataFrame
# missing_rows = missing_rows[df_current.columns]
#
# # Append the missing rows to the current DataFrame
# df_updated = pd.concat([df_current, missing_rows], ignore_index=True)
#
# # Save the updated DataFrame back to a CSV
# updated_output_path = '1_to_12_updated.csv'
# df_updated.to_csv(updated_output_path, index=False)
#
# print(f"Updated DataFrame saved with {len(df_updated)} rows, including {len(missing_ids)} added rows for missing IDs.")
