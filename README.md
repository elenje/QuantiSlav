# QuantiSlav
Preprocessing scripts and tools for the QuantiSlav project

# QuantiSlav

Digital-Humanities-Projekt zur quantitativen Analyse altkirchenslavischer und kirchenslavischer historischer Texte.

## Über das Projekt

QuantiSlav entwickelt computergestützte Methoden und Werkzeuge zur Verarbeitung historischer low-resource-Varietäten slavischer Sprachen, insbesondere altkirchenslavischer und kirchenslavischer Handschriften. Das Projekt verbindet Handschriftenerkennung (HTR), Korpuslinguistik und digitale Philologie.

## Repository-Struktur

```
QuantiSlav/
└── DHd2026/
    └── htr_preprocessing/
        ├── extract_unique_characters.R
        ├── replace_characters_in_XML.R
        ├── README_extract_unique_characters.md
        ├── README_replace_characters_in_XML.md
        └── README.md
```

### DHd2026

Materialien und Beiträge für die **DHd2026-Konferenz** (Digital Humanities im deutschsprachigen Raum).

**Konferenzbeitrag:** "Wohin mit all dem 'Kleinkram'? Zum Umgang mit Vorverarbeitungsskripten im HTR-Workflow"

#### [htr_preprocessing/](./DHd2026/htr_preprocessing/)

Vorverarbeitungsskripte für HTR-Workflows (Handwritten Text Recognition), speziell entwickelt zur Bewältigung von Unicode-Normalisierungsherausforderungen bei historischen Handschriftentranskriptionen.

**Inhalt:**
- Werkzeuge zur Unicode-Zeichenextraktion und -analyse
- Automatisierte Zeichenersetzung für PAGE-XML-Dateien (Transkribus-Format)
- Umfassende Dokumentation mit Anwendungsbeispielen

Diese Skripte adressieren das häufige Problem nicht-standardisierter Unicode-Zeichen und Private Use Area (PUA)-Zeichen in historischen Texttranskriptionsprojekten.

[→ Zur vollständigen Dokumentation](./DHd2026/htr_preprocessing/README.md)

## Hauptmerkmale

- **FAIR-konform:** Skripte sind nach den FAIR-Prinzipien dokumentiert (Findable, Accessible, Interoperable, Reusable)
- **Transkribus-kompatibel:** Entwickelt für PAGE-XML-Dateien der Transkribus-HTR-Plattform
- **Open Source:** MIT-Lizenz für maximale Wiederverwendbarkeit
- **Gut dokumentiert:** Umfassende READMEs mit Beispielen, Fehlerbehebung und Best Practices

## Anwendungsfälle

- Vorbereitung von Trainingsdaten für HTR-Modelle
- Unicode-Normalisierung in historischen Textkorpora
- Qualitätssicherung in digitalen Transkriptionsprojekten
- Migration von PUA zu standardisierten Unicode-Codepoints
- Harmonisierung der Zeichenkodierung über Datensätze aus verschiedenen Quellen

## Projektinformationen

**Institution:** Universität Freiburg (UFR) & Bayerische Akademie der Wissenschaften (BAdW)  
**Projekt:** QuantiSlav - Quantitative Verarbeitung von Altkirchenslavisch und Kirchenslavisch  
**Programmiersprache:** R  
**Lizenz:** MIT License (siehe jeweilige Unterverzeichnisse)

## Erste Schritte

Um die HTR-Vorverarbeitungsskripte zu verwenden:

1. Navigieren Sie zu [`DHd2026/htr_preprocessing/`](./DHd2026/htr_preprocessing/)
2. Lesen Sie die Haupt-README und die individuellen Skript-Dokumentationen
3. Installieren Sie die erforderlichen R-Pakete (`tidyverse`, `stringr`, `xlsx`, `readxl`)
4. Passen Sie die Skripte an Ihre spezifischen Korpus-Bedürfnisse an

## Zitation

Wenn Sie diese Skripte in Ihrer Forschung verwenden, zitieren Sie bitte wie folgt:

```
[Autorenname(n)] (2026). QuantiSlav HTR Preprocessing Scripts. 
Präsentiert auf der DHd2026-Konferenz. 
GitHub-Repository: https://github.com/[username]/QuantiSlav
```

## Beiträge

Wir freuen uns über Beiträge, Fehlerberichte und Verbesserungsvorschläge! Bitte:
- Öffnen Sie ein Issue für Bugs oder Feature-Requests
- Reichen Sie Pull Requests mit Verbesserungen ein
- Teilen Sie Ihre Anwendungsfälle und Anpassungen

## Kontakt

Für Fragen, Kooperationsanfragen oder Feedback:

**E-Mail:** [ihre.email@institution.de]  
**Projekt-Website:** [falls vorhanden]

## Danksagung

Diese Arbeit wurde im Rahmen des QuantiSlav-Projekts entwickelt, gefördert durch [Förderorganisation, falls zutreffend].

Besonderer Dank gilt der Transkribus-Plattform und der Digital-Humanities-Community für die kontinuierliche Unterstützung und Zusammenarbeit.

## Weiterführende Ressourcen

- [Transkribus-Plattform](https://transkribus.eu/)
- [PAGE-XML-Format-Dokumentation](https://github.com/PRImA-Research-Lab/PAGE-XML)
- [Unicode-Standard](https://unicode.org/)
- [FAIR-Prinzipien](https://www.go-fair.org/fair-principles/)

---

**Stand:** Dezember 2024  
**Version:** 1.0  
**Status:** Aktive Entwicklung

