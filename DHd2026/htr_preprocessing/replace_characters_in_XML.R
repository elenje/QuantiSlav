# Load required library for reading Excel files
library(readxl)

# ------------------- USER INPUT -------------------

# Path to the Excel file containing the replacement mappings
# The Excel file must contain two columns:
# - First column: characters to replace
# - Second column: replacement characters
replacement_file <- "path/to/replacement_mappings.xlsx"

# Directory containing PAGE-XML files exported from Transkribus
xml_files_directory <- "path/to/page_xml_files/"

# --------------------------------------------------

# Read the replacement mappings from the Excel file
replacement_mappings <- read_excel(replacement_file)

# Define a function to perform replacements in a given string
replace_characters <- function(sentence, replacement_mappings) {
  for (j in 1:nrow(replacement_mappings)) {
    from <- replacement_mappings[j, 1]
    to <- replacement_mappings[j, 2]
    # Replace using fixed = TRUE to match literal characters
    sentence <- gsub(from, to, sentence, fixed = TRUE)
  }
  return(sentence)
}

# Get a list of all XML files in the specified directory
xml_files <- list.files(xml_files_directory, pattern = "\\.xml$", full.names = TRUE)

# Iterate through each XML file to apply replacements
for (xml_file in xml_files) {
  # Read the content of the XML file line by line
  xml_content <- readLines(xml_file)
  
  # Pattern to match <Unicode>...</Unicode> tags
  pattern <- "<Unicode>(.*?)<\\/Unicode>"
  
  # Process each line individually
  for (i in seq_along(xml_content)) {
    matches <- regmatches(xml_content[i], gregexpr(pattern, xml_content[i], perl = TRUE))[[1]]
    
    # If any Unicode tags were found in the line
    if (length(matches) > 0) {
      for (match in matches) {
        # Replace characters inside the matched <Unicode> tag
        replaced_content <- replace_characters(match, replacement_mappings)
        # Substitute the modified content back into the line
        xml_content[i] <- gsub(match, replaced_content, xml_content[i], fixed = TRUE)
      }
    }
  }
  
  # Write the updated content back to the same file
  writeLines(xml_content, xml_file)
  cat("Replacements applied to:", xml_file, "\n")
}