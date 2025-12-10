# extract_unique_characters.R

## Description

Systematic identification and extraction of all unique characters from a corpus of text transcription files. Particularly useful for quality control before HTR (Handwritten Text Recognition) model training and for identifying non-standardized Unicode characters.

---

## Metadata

**Author:** Elena Renje, elena.renje[at]slavistik.uni-freiburg.de
**Date:** 10.12.2025 
**Version:** 1.0  
**License:** MIT License  
**Language:** R (Version ≥ 3.6 recommended)

---

## How It Works

The script performs the following steps:

1. Reads all .txt files from a specified directory
2. Extracts all characters from each file
3. Collects all unique characters across all files
4. Creates a consolidated list without duplicates
5. Exports the result to an Excel file with a named worksheet

---

## Technical Details

### Required Libraries
```R
library(tidyverse)  # Data processing
library(stringr)    # String manipulation
library(xlsx)       # Excel export
```

### System Requirements
- R Version ≥ 3.6
- Java Runtime Environment (JRE) for the `xlsx` package
- **Alternative without Java:** Use `openxlsx` package

### Encoding Requirement
- All input files must be UTF-8 encoded

---

## Input

- **Type:** Directory containing .txt files
- **Encoding:** UTF-8
- **Path Variable:** `input_folder` (adjust line 7 in the script)

**Example:**
```R
input_folder <- "C:/Projects/Transkribus/Transcriptions/"
```

---

## Output

- **Type:** Excel file (.xlsx)
- **Worksheet:** "Unicode_Characters"
- **Content:** One column containing all unique characters (one character per row)
- **Path Variable:** `output_file` (adjust line 10 in the script)

**Example:**
```R
output_file <- "unique_chars_corpus_2024.xlsx"
```

**Output Format:**
```
| all_unique_chars |
|------------------|
| а                |
| б                |
| ҃                |
| ...              |
```

---

## Usage

### Installing Packages
```R
install.packages("tidyverse")
install.packages("stringr")
install.packages("xlsx")
```

### Running the Script
```R
# 1. Adjust paths in the script (lines 7 and 10)
input_folder <- "C:/My/Path/to/textfiles/"
output_file <- "my_characters.xlsx"

# 2. Execute the script
source("extract_unique_characters.R")
```

### Alternative: Pass Paths as Parameters
If you want to use the script frequently with different paths, you can convert it into a function:

```R
source("extract_unique_characters.R")

# Then call with different paths
# (requires adapting the script to a function)
```

---

## Example Usage

```R
# Load libraries
library(tidyverse)
library(stringr)
library(xlsx)

# Define paths
input_folder <- "C:/Projects/Church_Slavonic/Transcriptions_2024/"
output_file <- "unicode_characters_corpus_2024.xlsx"

# Execute script
source("extract_unique_characters.R")

# Expected console output:
# "Unique characters successfully written to unicode_characters_corpus_2024.xlsx"
```

---

## Use Cases

- **HTR Model Training:** Identifying the character repertoire before training
- **Quality Assurance:** Detecting encoding errors or unwanted characters
- **Private Use Area (PUA):** Finding non-standardized Unicode characters
- **Corpus Documentation:** Complete documentation of characters used
- **Data Cleaning:** Preparation for subsequent normalization steps

---

## Notes and Limitations

### ⚠️ Important Notes

- **UTF-8 Required:** Only works with UTF-8 encoded files
- **Performance:** For very large corpora (>10,000 files), runtime may be several minutes
- **All Characters:** The script collects ALL characters, including:
  - Whitespace (spaces, tabs, line breaks)
  - Control characters
  - Punctuation marks
  - Special characters


## Workflow Integration

### Recommended Workflow for HTR Projects

1. **Character Extraction:** Run this script on your corpus
2. **Analysis:** Open Excel file and identify problematic characters
   - Mark PUA characters
   - Flag non-Unicode characters
   - Document inconsistencies
3. **Create Mapping:** Prepare replacement table for `replace_characters_in_XML.R`
4. **Normalization:** Replace characters with the second script
5. **Verification:** Run character extraction again for quality control

---

## Extension Possibilities

Possible improvements to the script:

- **Functionalization:** Convert to a callable function with parameters
- **Encoding Detection:** Automatic encoding detection
- **Statistics:** Capture character frequency
- **Progress Indicator:** Progress bar for large corpora
- **Categorization:** Grouping by Unicode blocks
- **Export Options:** Additional output formats (CSV, JSON)

---

## Troubleshooting

### Problem: "Error in file(file, "rt") : cannot open the connection"
**Solution:** Check that the `input_folder` path is correct and the files exist.

### Problem: "Error: package 'xlsx' is not available"
**Solution:** Install Java Runtime Environment or use `openxlsx` as an alternative.

### Problem: Script finds no files
**Solution:** 
- Ensure files have the `.txt` extension
- Use the full path (absolute path)
- On Windows: Use forward slashes (`/`) instead of backslash (`\`)

### Problem: Incorrect characters in output
**Solution:** Verify that input files are actually UTF-8 encoded. Convert with a text editor or:
```R
# Convert encoding
readLines("file.txt", encoding = "ISO-8859-1") %>%
  writeLines("file_utf8.txt", useBytes = FALSE)
```

---

## Contact

For questions, bug reports, or suggestions for improvement:  
**Email:** elena.renje[at]slavistik.uni-freiburg.de

---



## License

MIT License

Copyright (c) [2025] [Elena Renje, Anna Jouravel, Achim Rabus, Martin Meindl, Piroska Lendvai]

**Repository:** [GitHub/https://github.com/elenje/QuantiSlav/tree/main/DHd2026/htr_preprocessing]
