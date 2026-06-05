#import "lib.typ": *
#import "@preview/treet:1.0.0": *

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
  author: "Fabio Tozzi",
  title: "L'arte di non saper scrivere",
  description: "BSc thesis in Computer Science, University of Padova",
  supervisor: "Prof. Big T",
  university-id: "2222777",
  academic-year: "2024-2025",
  department: [Dipartimento di Matematics 'Tullio Levi-Civita'],
  degree: [Scienze Insulse],
  degree-type: "bachelor",
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
  Write a short summary of your thesis here. This section appears in the
  preface and gives the reader an overview of the contents.
]

#toc()

// Main content
#show: main

= Introduction

Write your introduction here. Use #acr("API") to reference acronyms and
#gls("example-term") to reference glossary terms.

== Background

Add chapters as needed @example-site.

#lorem(2000)

// Back matter
#show: back-matter

= Glossario

#print-glossary()

= Acronimi

#print-acronyms()

/* full param setted true is needed to show all the entries (including those without a citation) in the bibliography*/
#bibliography(
  "bibliography.yml",
  title: "Bibliografia",
  style: "the-institution-of-engineering-and-technology",
  full: true,
)
