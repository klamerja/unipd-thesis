#import "lib.typ": *

// Glossary
#let glossary = (
  (
    key: "example-term",
    display_name: [_Example term_],
    description: [Definition of the example term goes here.],
  ),
)

#init-glossary(glossary)

// Acronyms
#let acronyms = (
  "API": [_Application Programming Interface_],
  "UI": [_User Interface_],
)

#init-acronyms(acronyms)

// Document config
#show: thesis-config.with(
  printable: true,
  lang: "it",
  document-date: datetime(year: 2026, month: 9, day: 16),
  metadata: (
    title: "L'arte di non saper scrivere",
    author: (
      name: "Fabio Tozzi",
      student-id: "2222777",
    ),
    supervisors: (
      (
        role: "supervisor",
        title: "Prof.",
        name: "Big T",
      ),
    ),
    academic-year: "2024-2025",
    department: [Dipartimento di Matematica 'Tullio Levi-Civita'],
    degree: [Scienze Insulse],
    degree-type: "bachelor",
    description: "BSc thesis in Computer Science, University of Padova",
  ),
)

// Cover
#cover()

// Preface
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

Add chapters as needed @example-site.

#lorem(2000)

// Back matter
#show: back-matter

= #glossary-title()

#print-glossary()

= #acronyms-title()

#print-acronyms()

// `full: true` shows entries even when they are not cited in the text.
#bibliography(
  "bibliography.yml",
  title: "Bibliografia",
  style: "the-institution-of-engineering-and-technology",
  full: true,
)
