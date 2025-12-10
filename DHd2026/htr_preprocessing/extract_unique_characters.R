# Load required libraries for data handling, string manipulation, and Excel export
library(tidyverse)
library(stringr)
library(xlsx)

# Set the path to the folder containing the input .txt transcription files
input_folder <- "path/to/your/textfiles/"

# Define the path and filename for the Excel output
output_file <- "unique_characters_output.xlsx"

# Initialize an empty character vector to store all unique characters
all_unique_chars <- c()

# Get a list of all .txt files in the input folder
files <- list.files(input_folder, pattern = "\\.txt$", full.names = TRUE)

# Loop through each text file and extract unique characters
for (file in files) {
  # Read the file line by line (as a single-column data frame)
  text <- read.delim(file, header = FALSE, stringsAsFactors = FALSE, sep = "\n")
  
  # Flatten all lines into a single string
  text <- str_flatten(text[, 1])
  
  # Split the string into individual characters
  chars <- strsplit(text, split = "")
  
  # Extract the unique characters from the current file
  unique_chars <- unique(chars[[1]])
  
  # Combine with previously found characters, ensuring uniqueness
  all_unique_chars <- unique(c(all_unique_chars, unique_chars))
}

# Convert the final list of unique characters into a data frame
unique_chars_df <- as.data.frame(all_unique_chars)

# Export the list of unique characters to an Excel file
write.xlsx(unique_chars_df, file = output_file, sheetName = "Unicode_Characters",
           col.names = TRUE, row.names = FALSE, append = FALSE)

# Print confirmation message
cat("Unique characters successfully written to", output_file, "\n")