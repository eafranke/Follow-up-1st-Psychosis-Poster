# Set working directory
setwd("C:/Users/coule/OneDrive - Bentley University/Chow/HMS/Merge")

# Load required libraries
library(readr)   # For reading CSV files
library(dplyr)   # For data manipulation

# Step 1: Load 'subset' dataset from CSV while ensuring PAT_MRN_ID is a string
subset <- read_csv("275 HMSFirst.csv", col_types = cols(
  PAT_MRN_ID = col_character()  # Preserve leading zeros
))

# Step 2: Load 'first' dataset from CSV while ensuring PAT_MRN_ID is a string
first <- read_csv("first_episode_1-22-25.csv", col_types = cols(
  PAT_MRN_ID = col_character()  # Preserve leading zeros
))

# Step 3: Filter 'first' to keep only IDs that exist in 'subset'
filtered_first <- first %>% filter(PAT_MRN_ID %in% subset$PAT_MRN_ID)

# Step 4: Perform the merge (keeping all relevant columns)
merged_df <- left_join(filtered_first, subset, by = "PAT_MRN_ID")

# Step 5: Save the merged dataset to a new CSV file
write_csv(merged_df, "HMS Merged.csv")

# Step 6: Print summary statistics for the merged dataset (clean output)
cat("✅ Merge Completed!\n")
cat("Unique IDs in merged dataset:", n_distinct(merged_df$PAT_MRN_ID), "\n")
cat("Total observations in merged dataset:", nrow(merged_df), "\n")

# Step 7: Verify that PAT_MRN_ID maintains leading zeros (but only show the first few)
cat("\nSample PAT_MRN_ID values:\n")
print(head(merged_df$PAT_MRN_ID, 10))
