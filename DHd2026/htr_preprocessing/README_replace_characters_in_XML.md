# replace_characters_in_XML.R

## Beschreibung

Automatisierte Ersetzung nicht-standardisierter oder benutzerdefinierter Zeichen in Transkribus PAGE-XML-Dateien basierend auf einer benutzerdefinierten Mapping-Tabelle. Ermöglicht die konsistente Normalisierung von Zeichencodierungen im gesamten Korpus für HTR-Workflows (Handwritten Text Recognition).

---

## Metadaten

**Datum:** 10.12.2025
**Version:** 1.0.1
**Lizenz:** MIT License  
**Sprache:** R (Version ≥ 3.6 empfohlen)

---

## Funktionsweise

Das Skript durchläuft folgende Schritte:

1. Liest eine Excel-Tabelle mit Ersetzungsregeln (Mapping) ein
2. Durchläuft alle XML-Dateien im angegebenen Verzeichnis
3. Sucht gezielt innerhalb von `<Unicode>`-Tags nach zu ersetzenden Zeichen
4. Führt die Ersetzungen sequenziell gemäß der Mapping-Tabelle durch
5. Überschreibt die Original-XML-Dateien mit den bereinigten Versionen

**Wichtig:** Das Skript arbeitet nur innerhalb von `<Unicode>`-Tags, andere XML-Strukturen bleiben unverändert.

---

## Technische Details

### Benötigte Libraries
```R
library(readxl)  # Lesen von Excel-Dateien
```

### Technische Eigenschaften
- **Regex-Engine:** Perl-kompatibel (`perl = TRUE`)
- **Ersetzungslogik:** Literal matching (`fixed = TRUE`) zur Vermeidung von Regex-Problemen
- **Pattern:** `<Unicode>(.*?)<\/Unicode>` für Tag-Extraktion

### Funktionsdefinition im Skript
```R
replace_characters <- function(sentence, replacement_mappings)
```
Diese interne Funktion führt die eigentliche Ersetzung durch, indem sie iterativ durch alle Mapping-Zeilen geht.

---

## Input

### 1. Replacement-Mapping-Datei (Excel, .xlsx)

**Pfad-Variable:** `replacement_file` (Zeile 10 im Skript anpassen)

**Struktur:**
- **Zwei Spalten** (keine Spaltennamen erforderlich)
- **Spalte 1:** Zeichen/Zeichenketten, die ersetzt werden sollen
- **Spalte 2:** Zielzeichen/Ersatzzeichenketten

**Beispiel für replacement_mappings.xlsx:**

| Spalte 1 (zu ersetzen) | Spalte 2 (Ersatz)      |
|------------------------|------------------------|
| ѿ                      | ѿ                      |
| ҃                      | ҃                      |
| ї                      | і                      |
|                       |                       |

**Hinweise zur Mapping-Tabelle:**
- Keine Spaltenüberschriften notwendig
- Auch mehrbuchstabige Strings können ersetzt werden (z.B. "ae" → "ä")
- Leerzeilen werden ignoriert
- Die Reihenfolge ist wichtig bei überlappenden Ersetzungen

### 2. XML-Dateien (PAGE-XML-Format)

**Pfad-Variable:** `xml_files_directory` (Zeile 13 im Skript anpassen)

**Eigenschaften:**
- PAGE-XML-Format aus Transkribus
- Enthält `<Unicode>`-Tags mit Textinhalt
- Beliebige Anzahl von XML-Dateien im Verzeichnis

---

## Output

- **Die Original-XML-Dateien werden direkt überschrieben** ⚠️
- Alle Zeichen innerhalb von `<Unicode>`-Tags werden entsprechend der Mapping-Tabelle ersetzt
- **Konsolenausgabe:** Bestätigung für jede verarbeitete Datei
  ```
  Replacements applied to: pfad/zur/datei1.xml
  Replacements applied to: pfad/zur/datei2.xml
  ...
  ```

---

## Verwendung

### Installation der Pakete
```R
install.packages("readxl")
```

### Vorbereitung

1. **Mapping-Tabelle erstellen:**
   - Excel-Datei mit zwei Spalten anlegen
   - Zu ersetzende Zeichen in Spalte 1
   - Ersatzzeichen in Spalte 2
   - Als .xlsx speichern

2. **Backup erstellen:** ⚠️ **KRITISCH!**
   ```R
   # Beispiel für Windows
   file.copy("C:/Original/XML/", "C:/Backup/XML/", recursive = TRUE)
   ```

3. **Pfade im Skript anpassen** (Zeilen 10 und 13)

### Skript ausführen

```R
# 1. Library laden
library(readxl)

# 2. Pfade im Skript anpassen
replacement_file <- "C:/Mein/Pfad/zu/mappings.xlsx"
xml_files_directory <- "C:/Mein/Pfad/zu/XML_Dateien/"

# 3. Skript ausführen
source("replace_characters_in_XML.R")
```

---

## Aufrufbeispiel

```R
library(readxl)

# Pfade definieren
replacement_file <- "C:/Projekte/Kirchenslavisch/unicode_normalisierung.xlsx"
xml_files_directory <- "C:/Projekte/Transkribus/PageXML_Export_2024/"

# Skript ausführen
source("replace_characters_in_XML.R")

# Erwartete Konsolenausgabe:
# Replacements applied to: C:/Projekte/Transkribus/PageXML_Export_2024/page_001.xml
# Replacements applied to: C:/Projekte/Transkribus/PageXML_Export_2024/page_002.xml
# ...
```

---

## Use Cases

### Hauptanwendungsfälle

1. **HTR-Modelltraining vorbereiten**
   - Normalisierung der Trainingsdaten vor dem Modelltraining
   - Sicherstellung konsistenter Zeichenverwendung

2. **Unicode-Normalisierung**
   - Migration von Private Use Area (PUA) zu standardisierten Unicode-Codepoints
   - Vereinheitlichung verschiedener Unicode-Varianten (z.B. kombinierte vs. präkomponierte Zeichen)

3. **Datenintegration**
   - Vereinheitlichung von Daten aus verschiedenen Quellen
   - Harmonisierung unterschiedlicher Transkriptionskonventionen

4. **Fehlerkorrektur**
   - Behebung systematischer Kodierungsfehler
   - Korrektur falsch verwendeter Zeichen

5. **Variantennormalisierung**
   - Vereinheitlichung von Schreibvarianten
   - Normalisierung diakritischer Zeichen

---

## Praktisches Beispiel: PUA-Migration

### Szenario
Ihre Transkribus-Daten enthalten Private Use Area (PUA) Zeichen, die Sie in standardisierte Unicode-Zeichen überführen möchten.

### Schritt-für-Schritt

**1. Zeichen identifizieren** (mit `extract_unique_characters.R`):
```
Gefundene Zeichen:
  (U+F700) - PUA-Zeichen
  (U+F701) - PUA-Zeichen
```

**2. Mapping-Tabelle erstellen** (`pua_normalisierung.xlsx`):
| Alt (PUA)    | Neu (Standard) |
|--------------|----------------|
|  (U+F700)   | ѿ (U+047F)     |
|  (U+F701)   | ҃ (U+0483)     |

**3. Backup erstellen:**
```R
dir.create("C:/Backup/PageXML_2024-12-10")
file.copy("C:/Projekt/PageXML/", "C:/Backup/PageXML_2024-12-10/", 
          recursive = TRUE)
```

**4. Skript ausführen:**
```R
library(readxl)
replacement_file <- "C:/Projekt/pua_normalisierung.xlsx"
xml_files_directory <- "C:/Projekt/PageXML/"
source("replace_characters_in_XML.R")
```

**5. Verifikation:**
```R
# Erneut Zeichenextraktion durchführen
source("extract_unique_characters.R")
# Überprüfen, ob PUA-Zeichen verschwunden sind
```

---

## Wichtige Hinweise

### ⚠️ KRITISCHE Warnungen

1. **Unwiderrufliches Überschreiben**
   - Das Skript überschreibt die Original-XML-Dateien direkt
   - Es gibt KEINE automatische Backup-Funktion
   - **Erstellen Sie IMMER ein Backup vor der Ausführung!**

2. **Sequenzielle Ersetzung**
   - Die Ersetzungen erfolgen in der Reihenfolge der Mapping-Tabelle
   - Bei überlappenden Regeln kann die Reihenfolge das Ergebnis beeinflussen
   - Beispiel: 
     ```
     Regel 1: "ab" → "x"
     Regel 2: "a" → "y"
     Text "abc" wird zu "xc" (nicht "ybc")
     ```

3. **Nur Unicode-Tags betroffen**
   - Das Skript arbeitet ausschließlich innerhalb von `<Unicode>`-Tags
   - Andere XML-Strukturen, Attribute oder Tags bleiben unverändert

### ✅ Best Practices

1. **Immer zuerst auf Testdaten prüfen**
   - Kopieren Sie 2-3 XML-Dateien in einen Testordner
   - Führen Sie das Skript dort zuerst aus
   - Kontrollieren Sie das Ergebnis manuell

2. **Versionskontrolle verwenden**
   - Dateinamen mit Datum versehen
   - Mapping-Tabellen versionieren
   - Backup-Ordner mit Zeitstempel

3. **Dokumentation der Ersetzungen**
   - Begründung für jede Ersetzung notieren
   - Mapping-Tabelle im Projekt archivieren
   - Änderungshistorie führen

---

## Workflow-Integration

### Empfohlener Gesamtworkflow

```
1. Zeichenidentifikation
   └─> extract_unique_characters.R ausführen

2. Analyse & Planung
   └─> Excel-Ausgabe analysieren
   └─> Problematische Zeichen identifizieren
   └─> Ersetzungsstrategie festlegen

3. Mapping erstellen
   └─> Excel-Tabelle mit Ersetzungsregeln anlegen
   └─> Dokumentation der Entscheidungen

4. Backup
   └─> Vollständige Kopie der XML-Dateien erstellen
   └─> Backup-Pfad dokumentieren

5. Test
   └─> Skript auf 2-3 Test-Dateien anwenden
   └─> Manuelle Kontrolle der Ergebnisse
   └─> Bei Bedarf Mapping anpassen

6. Produktion
   └─> replace_characters_in_XML.R auf gesamtem Korpus
   └─> Konsolenausgaben überprüfen

7. Verifikation
   └─> Erneut extract_unique_characters.R ausführen
   └─> Vergleich vorher/nachher
   └─> Qualitätskontrolle

8. Dokumentation
   └─> Änderungen dokumentieren
   └─> Mapping-Tabelle archivieren
```

---

## Fehlerbehebung

### Problem: "Error in read_excel(): path does not exist"
**Lösung:** 
- Überprüfen Sie den Pfad zur Excel-Datei
- Verwenden Sie den vollständigen Pfad
- Stellen Sie sicher, dass die Datei .xlsx ist

### Problem: Ersetzungen werden nicht durchgeführt
**Lösung:**
- Prüfen Sie, ob die XML-Dateien tatsächlich `<Unicode>`-Tags enthalten
- Überprüfen Sie die Mapping-Tabelle auf korrekte Struktur (2 Spalten)
- Testen Sie mit einer einfachen Ersetzung (z.B. "a" → "b")

### Problem: Skript bricht mit Fehler ab
**Lösung:**
- Überprüfen Sie, ob alle XML-Dateien wohlgeformt sind
- Prüfen Sie auf Sonderzeichen in Dateinamen
- Kontrollieren Sie Schreibrechte im XML-Verzeichnis

### Problem: Falsche Zeichen nach Ersetzung
**Lösung:**
- Überprüfen Sie die Reihenfolge in der Mapping-Tabelle
- Testen Sie die Ersetzungen einzeln
- Prüfen Sie auf überlappende Ersetzungsregeln

---

## Erweiterungsmöglichkeiten

Mögliche Verbesserungen des Skripts:

- **Automatisches Backup:** Vor der Ersetzung automatisch Backups erstellen
- **Logging:** Detailliertes Log aller Änderungen
- **Dry-Run-Modus:** Vorschau ohne tatsächliche Änderung
- **Diff-Report:** Vergleich vorher/nachher mit Statistiken
- **Rückgängig-Funktion:** Möglichkeit zur Wiederherstellung
- **Validierung:** Überprüfung der XML-Struktur nach Ersetzung
- **Batch-Verarbeitung:** Fortschrittsbalken für große Mengen
- **Conditional Replacement:** Kontextabhängige Ersetzungen

---

## Sicherheit und Datenintegrität

### Empfohlene Sicherheitsmaßnahmen

1. **3-2-1 Backup-Regel**
   - 3 Kopien Ihrer Daten
   - 2 verschiedene Medien
   - 1 externe/Cloud-Kopie

2. **Checksummen**
   ```R
   # MD5-Checksummen vor und nach der Verarbeitung
   library(tools)
   md5sum("datei.xml")
   ```

3. **Git/Versionskontrolle**
   - XML-Dateien und Mapping-Tabellen unter Versionskontrolle
   - Commit vor und nach der Ersetzung

---

## Kontakt

Bei Fragen, Fehlermeldungen oder Verbesserungsvorschlägen:  
**Email:** elena.renje[at]slavistik.uni-freiburg.de 

## Lizenz

MIT License

Copyright (c) [2025] [Elena Renje, Anna Jouravel, Achim Rabus, Martin Meindl, Piroska Lendvai]

**Letzte Aktualisierung:** [10.12.2025]  
**Repository:** [GitHub/https://github.com/elenje/QuantiSlav/tree/main/DHd2026/htr_preprocessing]
