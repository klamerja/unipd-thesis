#let _lang = state("thesis-lang", "it")

#let _strings = (
  it: (
    acknowledgements: "Ringraziamenti",
    summary: "Sommario",
    toc: "Indice",
    figures: "Elenco delle figure",
    listings: "Elenco dei codici",
    tables: "Elenco delle tabelle",
    academic-year: "Anno Accademico",
    thesis-label: "Tesi di laurea",
    thesis-label-master: "Tesi di laurea magistrale",
    degree-bachelor: "Corso di Laurea in",
    degree-master: "Corso di Laurea Magistrale in",
    supervisor: "Relatore",
    graduand: "Laureando",
    student-id: "Matricola",
    unipd: "Università degli Studi di Padova",
  ),
  en: (
    acknowledgements: "Acknowledgements",
    summary: "Abstract",
    toc: "Table of Contents",
    figures: "List of Figures",
    listings: "List of Listings",
    tables: "List of Tables",
    academic-year: "Academic Year",
    thesis-label: "Bachelor Thesis",
    thesis-label-master: "Master Thesis",
    degree-bachelor: "Bachelor Degree in",
    degree-master: "Master Degree in",
    supervisor: "Supervisor",
    graduand: "Graduate",
    student-id: "Student ID",
    unipd: "University of Padua",
  ),
)

#let t(key) = context _strings.at(_lang.get()).at(key)
