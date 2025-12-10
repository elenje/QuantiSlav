# extract_unique_characters.R

## Beschreibung

Systematische Identifikation und Extraktion aller eindeutigen Zeichen aus einem Korpus von .txt-Transkriptionsdateien. Besonders nützlich zur Qualitätskontrolle vor dem HTR-Modelltraining (Handwritten Text Recognition) und zur Identifikation nicht-standardisierter Unicode-Zeichen.

---

## Metadaten

**Autor:** [Name, Email]  
**Datum:** [Erstellungsdatum]  
**Version:** 1.0  
**Lizenz:** MIT License  
**Sprache:** R (Version ≥ 3.6 empfohlen)

---

## Funktionsweise

Das Skript durchläuft folgende Schritte:

1. Liest alle .txt-Dateien aus einem definierten Verzeichnis ein
2. Extrahiert aus jeder Datei alle Zeichen
3. Sammelt alle eindeutigen Zeichen über alle Dateien hinweg
4. Erstellt eine konsolidierte Liste ohne Duplikate
5. Exportiert das Ergebnis in eine Excel-Datei mit benanntem Arbeitsblatt

---

## Technische Details

### Benötigte Libraries
```R
library(tidyverse)  # Datenverarbeitung
library(stringr)    # String-Manipulation
library(xlsx)       # Excel-Export
```

### Systemvoraussetzungen
- R Version ≥ 3.6
- Java Runtime Environment (JRE) für das `xlsx`-Paket
- **Alternative ohne Java:** Paket `openxlsx` verwenden

### Encoding-Voraussetzung
- Alle Input-Dateien müssen UTF-8-kodiert sein

---

## Input

- **Typ:** Verzeichnis mit .txt-Dateien
- **Encoding:** UTF-8
- **Pfad-Variable:** `input_folder` (Zeile 7 im Skript anpassen)

**Beispiel:**
```R
input_folder <- "C:/Projekte/Transkribus/Transkriptionen/"
```

---

## Output

- **Typ:** Excel-Datei (.xlsx)
- **Arbeitsblatt:** "Unicode_Characters"
- **Inhalt:** Eine Spalte mit allen eindeutigen Zeichen (ein Zeichen pro Zeile)
- **Pfad-Variable:** `output_file` (Zeile 10 im Skript anpassen)

**Beispiel:**
```R
output_file <- "unique_chars_corpus_2024.xlsx"
```

**Ausgabe-Format:**
```
| all_unique_chars |
|------------------|
| а                |
| б                |
| ҃                |
| ...              |
```

---

## Verwendung

### Installation der Pakete
```R
install.packages("tidyverse")
install.packages("stringr")
install.packages("xlsx")
```

### Skript ausführen
```R
# 1. Pfade im Skript anpassen (Zeilen 7 und 10)
input_folder <- "C:/Mein/Pfad/zu/textfiles/"
output_file <- "meine_zeichen.xlsx"

# 2. Skript ausführen
source("extract_unique_characters.R")
```

### Alternative: Pfade als Parameter übergeben
Falls Sie das Skript häufiger mit verschiedenen Pfaden verwenden möchten, können Sie es auch in eine Funktion umwandeln:

```R
source("extract_unique_characters.R")

# Dann mit verschiedenen Pfaden aufrufen
# (erfordert Anpassung des Skripts zu einer Funktion)
```

---

## Aufrufbeispiel

```R
# Libraries laden
library(tidyverse)
library(stringr)
library(xlsx)

# Pfade definieren
input_folder <- "C:/Projekte/Kirchenslavisch/Transkriptionen_2024/"
output_file <- "unicode_zeichen_korpus_2024.xlsx"

# Skript ausführen
source("extract_unique_characters.R")

# Erwartete Ausgabe in der Konsole:
# "Unique characters successfully written to unicode_zeichen_korpus_2024.xlsx"
```

---

## Use Cases

- **HTR-Modelltraining:** Identifikation des Zeichenrepertoires vor dem Training
- **Qualitätssicherung:** Erkennung von Kodierungsfehlern oder unerwünschten Zeichen
- **Private Use Area (PUA):** Aufspüren nicht-standardisierter Unicode-Zeichen
- **Korpusdokumentation:** Vollständige Dokumentation verwendeter Zeichen
- **Datenbereinigung:** Vorbereitung für nachfolgende Normalisierungsschritte

---

## Hinweise und Limitationen

### ⚠️ Wichtige Hinweise

- **UTF-8 erforderlich:** Funktioniert nur mit UTF-8-kodierten Dateien
- **Performance:** Bei sehr großen Korpora (>10.000 Dateien) kann die Laufzeit mehrere Minuten betragen
- **Alle Zeichen:** Das Skript sammelt ALLE Zeichen, einschließlich:
  - Whitespace (Leerzeichen, Tabs, Zeilenumbrüche)
  - Steuerzeichen
  - Satzzeichen
  - Sonderzeichen

### 🐛 Bekannter Bug

**Zeile 44:** Falsche Variablenbezeichnung
```R
# Aktuell (fehlerhaft):
cat("Unique characters successfully written to", output_excel_file, "\n")

# Sollte sein:
cat("Unique characters successfully written to", output_file, "\n")
```

**Workaround:** Das Skript funktioniert trotzdem, nur die Ausgabemeldung zeigt einen Fehler. Sie können die Zeile entsprechend korrigieren.

---

## Workflow-Integration

### Empfohlener Workflow für HTR-Projekte

1. **Zeichenextraktion:** Dieses Skript auf Ihrem Korpus ausführen
2. **Analyse:** Excel-Datei öffnen und problematische Zeichen identifizieren
   - PUA-Zeichen markieren
   - Nicht-Unicode-Zeichen kennzeichnen
   - Inkonsistenzen dokumentieren
3. **Mapping erstellen:** Ersetzungstabelle für `replace_characters_in_XML.R` vorbereiten
4. **Normalisierung:** Mit dem zweiten Skript Zeichen ersetzen
5. **Verifikation:** Erneut Zeichenextraktion durchführen zur Qualitätskontrolle

---

## Erweiterungsmöglichkeiten

Mögliche Verbesserungen des Skripts:

- **Funktionalisierung:** Umwandlung in eine aufrufbare Funktion mit Parametern
- **Encoding-Erkennung:** Automatische Erkennung des Encodings
- **Statistiken:** Häufigkeit der Zeichen erfassen
- **Fortschrittsanzeige:** Progress bar für große Korpora
- **Kategorisierung:** Gruppierung nach Unicode-Blöcken
- **Export-Optionen:** Zusätzliche Ausgabeformate (CSV, JSON)

---

## Fehlerbehebung

### Problem: "Error in file(file, "rt") : cannot open the connection"
**Lösung:** Überprüfen Sie, ob der `input_folder`-Pfad korrekt ist und die Dateien existieren.

### Problem: "Error: package 'xlsx' is not available"
**Lösung:** Java Runtime Environment installieren oder `openxlsx` als Alternative verwenden.

### Problem: Skript findet keine Dateien
**Lösung:** 
- Stellen Sie sicher, dass die Dateien die Endung `.txt` haben
- Verwenden Sie den vollständigen Pfad (absolute path)
- Unter Windows: Schrägstriche verwenden (`/`) statt Backslash (`\`)

### Problem: Fehlerhafte Zeichen in der Ausgabe
**Lösung:** Überprüfen Sie, ob die Input-Dateien tatsächlich UTF-8-kodiert sind. Konvertierung mit einem Texteditor oder:
```R
# Encoding konvertieren
readLines("file.txt", encoding = "ISO-8859-1") %>%
  writeLines("file_utf8.txt", useBytes = FALSE)
```

---

## Kontakt

Bei Fragen, Fehlermeldungen oder Verbesserungsvorschlägen:  
**Email:** [Ihre Email-Adresse]

---

## Zitation

```
[Autor*innen] (Jahr). extract_unique_characters.R - Unicode-Zeichenextraktion 
für HTR-Workflows. [Repository-URL]. Version 1.0.
```

---

## Lizenz

MIT License

Copyright (c) [Jahr] [Autor*innen]

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

**Letzte Aktualisierung:** [Datum]  
**Repository:** [GitHub/GitLab-URL]
