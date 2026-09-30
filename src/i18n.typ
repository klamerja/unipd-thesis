#let _lang = state("thesis-lang", "it")

#let _strings = (
  it: (
    acknowledgements: "Ringraziamenti",
    summary: "Sommario",
    glossary: "Glossario",
    acronyms: "Acronimi",
    toc: "Indice",
    figures: "Elenco delle figure",
    code-blocks: "Elenco dei blocchi di codice",
    tables: "Elenco delle tabelle",
    academic-year: "Anno Accademico",
    thesis-label: "Tesi di laurea",
    thesis-label-master: "Tesi di laurea magistrale",
    degree-bachelor: "Corso di Laurea in",
    degree-master: "Corso di Laurea Magistrale in",
    supervisor: "Relatore",
    co-supervisor: "Correlatore",
    graduand: "Laureando",
    student-id: "Matricola",
    unipd: "Università degli Studi di Padova",
    unipd-logo-alt: "Logo dell'Università degli Studi di Padova",
    months: (
      "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
      "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre",
    ),
  ),
  en: (
    acknowledgements: "Acknowledgements",
    summary: "Abstract",
    glossary: "Glossary",
    acronyms: "Acronyms",
    toc: "Table of Contents",
    figures: "List of Figures",
    code-blocks: "List of Code Blocks",
    tables: "List of Tables",
    academic-year: "Academic Year",
    thesis-label: "Bachelor’s Thesis",
    thesis-label-master: "Master’s Thesis",
    degree-bachelor: "Bachelor’s Degree in",
    degree-master: "Master’s Degree in",
    supervisor: "Supervisor",
    co-supervisor: "Co-supervisor",
    graduand: "Candidate",
    student-id: "Student ID",
    unipd: "University of Padua",
    unipd-logo-alt: "University of Padua logo",
    months: (
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ),
  ),
)

#let t(key) = _strings.at(_lang.get()).at(key)
#let month-name(month) = _strings.at(_lang.get()).at("months").at(month - 1)
