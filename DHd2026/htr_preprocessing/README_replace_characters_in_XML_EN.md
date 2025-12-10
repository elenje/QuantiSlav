# replace_characters_in_XML.R

## Description

Automated replacement of non-standardized or custom characters in Transkribus PAGE-XML files based on a user-defined mapping table. Enables consistent normalization of character encodings across the entire corpus for HTR workflows (Handwritten Text Recognition).

---

## Metadata

**Author:** [Name, Email]  
**Date:** [Creation Date]  
**Version:** 1.0  
**License:** MIT License  
**Language:** R (Version ≥ 3.6 recommended)

---

## How It Works

The script performs the following steps:

1. Reads an Excel table with replacement rules (mapping)
2. Iterates through all XML files in the specified directory
3. Searches specifically within `<Unicode>` tags for characters to be replaced
4. Performs replacements sequentially according to the mapping table
5. Overwrites the original XML files with the cleaned versions

**Important:** The script only works within `<Unicode>` tags; other XML structures remain unchanged.

---

## Technical Details

### Required Libraries
```R
library(readxl)  # Reading Excel files
```

### Technical Properties
- **Regex Engine:** Perl-compatible (`perl = TRUE`)
- **Replacement Logic:** Literal matching (`fixed = TRUE`) to avoid regex problems
- **Pattern:** `<Unicode>(.*?)<\/Unicode>` for tag extraction

### Function Definition in Script
```R
replace_characters <- function(sentence, replacement_mappings)
```
This internal function performs the actual replacement by iterating through all mapping rows.

---

## Input

### 1. Replacement Mapping File (Excel, .xlsx)

**Path Variable:** `replacement_file` (adjust line 10 in the script)

**Structure:**
- **Two columns** (no column headers required)
- **Column 1:** Characters/strings to be replaced
- **Column 2:** Target characters/replacement strings

**Example for replacement_mappings.xlsx:**

| Column 1 (to replace) | Column 2 (replacement) |
|----------------------|------------------------|
| ѿ                     | ѿ                      |
| ҃                     | ҃                      |
| ї                     | і                      |
|                      |                        |

**Notes on the Mapping Table:**
- No column headers necessary
- Multi-character strings can also be replaced (e.g., "ae" → "ä")
- Empty rows are ignored
- Order matters for overlapping replacements

### 2. XML Files (PAGE-XML Format)

**Path Variable:** `xml_files_directory` (adjust line 13 in the script)

**Properties:**
- PAGE-XML format from Transkribus
- Contains `<Unicode>` tags with text content
- Any number of XML files in the directory

---

## Output

- **The original XML files are directly overwritten** ⚠️
- All characters within `<Unicode>` tags are replaced according to the mapping table
- **Console Output:** Confirmation for each processed file
  ```
  Replacements applied to: path/to/file1.xml
  Replacements applied to: path/to/file2.xml
  ...
  ```

---

## Usage

### Installing Packages
```R
install.packages("readxl")
```

### Preparation

1. **Create Mapping Table:**
   - Create Excel file with two columns
   - Characters to replace in column 1
   - Replacement characters in column 2
   - Save as .xlsx

2. **Create Backup:** ⚠️ **CRITICAL!**
   ```R
   # Example for Windows
   file.copy("C:/Original/XML/", "C:/Backup/XML/", recursive = TRUE)
   ```

3. **Adjust Paths in Script** (lines 10 and 13)

### Running the Script

```R
# 1. Load library
library(readxl)

# 2. Adjust paths in script
replacement_file <- "C:/My/Path/to/mappings.xlsx"
xml_files_directory <- "C:/My/Path/to/XML_Files/"

# 3. Execute script
source("replace_characters_in_XML.R")
```

---

## Example Usage

```R
library(readxl)

# Define paths
replacement_file <- "C:/Projects/Church_Slavonic/unicode_normalization.xlsx"
xml_files_directory <- "C:/Projects/Transkribus/PageXML_Export_2024/"

# Execute script
source("replace_characters_in_XML.R")

# Expected console output:
# Replacements applied to: C:/Projects/Transkribus/PageXML_Export_2024/page_001.xml
# Replacements applied to: C:/Projects/Transkribus/PageXML_Export_2024/page_002.xml
# ...
```

---

## Use Cases

### Main Applications

1. **Prepare HTR Model Training**
   - Normalization of training data before model training
   - Ensuring consistent character usage

2. **Unicode Normalization**
   - Migration from Private Use Area (PUA) to standardized Unicode codepoints
   - Unification of different Unicode variants (e.g., combined vs. precomposed characters)

3. **Data Integration**
   - Unification of data from different sources
   - Harmonization of different transcription conventions

4. **Error Correction**
   - Fixing systematic encoding errors
   - Correction of incorrectly used characters

5. **Variant Normalization**
   - Unification of spelling variants
   - Normalization of diacritical marks

---

## Practical Example: PUA Migration

### Scenario
Your Transkribus data contains Private Use Area (PUA) characters that you want to convert to standardized Unicode characters.

### Step-by-Step

**1. Identify Characters** (with `extract_unique_characters.R`):
```
Found characters:
   (U+F700) - PUA character
   (U+F701) - PUA character
```

**2. Create Mapping Table** (`pua_normalization.xlsx`):
| Old (PUA)    | New (Standard) |
|--------------|----------------|
|  (U+F700)   | ѿ (U+047F)     |
|  (U+F701)   | ҃ (U+0483)     |

**3. Create Backup:**
```R
dir.create("C:/Backup/PageXML_2024-12-10")
file.copy("C:/Project/PageXML/", "C:/Backup/PageXML_2024-12-10/", 
          recursive = TRUE)
```

**4. Execute Script:**
```R
library(readxl)
replacement_file <- "C:/Project/pua_normalization.xlsx"
xml_files_directory <- "C:/Project/PageXML/"
source("replace_characters_in_XML.R")
```

**5. Verification:**
```R
# Run character extraction again
source("extract_unique_characters.R")
# Check if PUA characters have disappeared
```

---

## Important Notes

### ⚠️ CRITICAL Warnings

1. **Irreversible Overwriting**
   - The script overwrites the original XML files directly
   - There is NO automatic backup function
   - **ALWAYS create a backup before execution!**

2. **Sequential Replacement**
   - Replacements occur in the order of the mapping table
   - For overlapping rules, order can affect the result
   - Example: 
     ```
     Rule 1: "ab" → "x"
     Rule 2: "a" → "y"
     Text "abc" becomes "xc" (not "ybc")
     ```

3. **Only Unicode Tags Affected**
   - The script works exclusively within `<Unicode>` tags
   - Other XML structures, attributes, or tags remain unchanged

### ✅ Best Practices

1. **Always Test on Sample Data First**
   - Copy 2-3 XML files to a test folder
   - Run the script there first
   - Check the result manually

2. **Use Version Control**
   - Version filenames with dates
   - Version mapping tables
   - Backup folders with timestamps

3. **Document Replacements**
   - Note justification for each replacement
   - Archive mapping table in project
   - Maintain change history

---

## Workflow Integration

### Recommended Overall Workflow

```
1. Character Identification
   └─> Run extract_unique_characters.R

2. Analysis & Planning
   └─> Analyze Excel output
   └─> Identify problematic characters
   └─> Define replacement strategy

3. Create Mapping
   └─> Create Excel table with replacement rules
   └─> Document decisions

4. Backup
   └─> Create complete copy of XML files
   └─> Document backup path

5. Test
   └─> Apply script to 2-3 test files
   └─> Manually check results
   └─> Adjust mapping if needed

6. Production
   └─> Run replace_characters_in_XML.R on entire corpus
   └─> Check console output

7. Verification
   └─> Run extract_unique_characters.R again
   └─> Compare before/after
   └─> Quality control

8. Documentation
   └─> Document changes
   └─> Archive mapping table
```

---

## Troubleshooting

### Problem: "Error in read_excel(): path does not exist"
**Solution:** 
- Check the path to the Excel file
- Use the full path
- Ensure the file is .xlsx

### Problem: Replacements are not performed
**Solution:**
- Check if XML files actually contain `<Unicode>` tags
- Verify mapping table has correct structure (2 columns)
- Test with a simple replacement (e.g., "a" → "b")

### Problem: Script aborts with error
**Solution:**
- Check if all XML files are well-formed
- Check for special characters in filenames
- Verify write permissions in XML directory

### Problem: Wrong characters after replacement
**Solution:**
- Check the order in the mapping table
- Test replacements individually
- Check for overlapping replacement rules

---

## Extension Possibilities

Possible improvements to the script:

- **Automatic Backup:** Create backups automatically before replacement
- **Logging:** Detailed log of all changes
- **Dry-Run Mode:** Preview without actual changes
- **Diff Report:** Before/after comparison with statistics
- **Undo Function:** Ability to restore
- **Validation:** Verify XML structure after replacement
- **Batch Processing:** Progress bar for large quantities
- **Conditional Replacement:** Context-dependent replacements

---

## Security and Data Integrity

### Recommended Security Measures

1. **3-2-1 Backup Rule**
   - 3 copies of your data
   - 2 different media
   - 1 external/cloud copy

2. **Checksums**
   ```R
   # MD5 checksums before and after processing
   library(tools)
   md5sum("file.xml")
   ```

3. **Git/Version Control**
   - XML files and mapping tables under version control
   - Commit before and after replacement

---

## Contact

For questions, bug reports, or suggestions for improvement:  
**Email:** [Your Email Address]  
**Issue Tracker:** [GitHub Issues URL]

---

## Citation

```
[Author(s)] (Year). replace_characters_in_XML.R - Character Normalization 
for PAGE-XML in HTR Workflows. [Repository URL]. Version 1.0.
```

---

## License

MIT License

Copyright (c) [Year] [Author(s)]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

**Last Updated:** [Date]  
**Repository:** [GitHub/GitLab URL]
