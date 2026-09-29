#import "@preview/unipd-thesis:0.1.0": *

// Glossary
#let my-glossary = (
  (
    key: "example-term",
    display_name: [_Example term_],
    description: [Definition of the example term goes here.],
  ),
)

#init-glossary(my-glossary)

// Acronyms
#let my-acronyms = (
  "API": [_Application Programming Interface_],
  "UI": [_User Interface_],
)

#init-acronyms(my-acronyms)

// Document configuration
#show: thesis-config.with(
  lang: "it",
  printable: true,
  document-date: datetime(year: 2026, month: 1, day: 1), // Replace with a fixed date.
  metadata: (
    title: "Your Thesis Title",
    author: (
      name: "Your Name",
      student-id: "0000000",
      // Optional: e.g. "Laureanda" instead of the default "Laureando".
      // label: "Laureanda",
    ),
    supervisors: (
      (
        role: "supervisor",
        title: "Prof.",
        name: "Supervisor Name",
      ),
    ),
    academic-year: "2026-2027",
    department: [Dipartimento di Matematica 'Tullio Levi-Civita'],
    degree: [Informatica],
    degree-type: "bachelor", // "bachelor" | "master"
    description: "BSc thesis in Computer Science, University of Padua",
  ),
)

#cover()

#show: preface

#copyright()

#dedication(phrase: [_To someone special._])

#acknowledgements(
  quote: "Quote text here.",
  quote-author: "Author Name",
)[
  Write your acknowledgements here.
]

#summary[
  Write a short summary of your thesis here. This section appears in the preface and gives the reader an overview of the contents.
]

#toc()

// Main content
#show: main

= Introduction

Write your introduction here. Use #acr("API") to reference acronyms and #gls("example-term") to reference glossary terms.

== Background

Add chapters as needed.

// Back matter
#show: back-matter

= #glossary-title()

#print-glossary()

= #acronyms-title()

#print-acronyms()
