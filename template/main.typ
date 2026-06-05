#import "@preview/unipd-thesis:0.1.0": *

// ── Glossary entries ───────────────────────────────────────────────────────
#let my-glossary = (
  (
    key: "example-term",
    display_name: [_Example term_],
    description: [Definition of the example term goes here.],
  ),
)

#init-glossary(my-glossary)

// ── Acronyms ───────────────────────────────────────────────────────────────
#let my-acronyms = (
  "API": [_Application Programming Interface_],
  "UI": [_User Interface_],
)

#init-acronyms(my-acronyms)

// ── Document config ────────────────────────────────────────────────────────
#show: thesis-config.with(
  lang: "it",
  author: "Your Name",
  title: "Your Thesis Title",
  description: "BSc thesis in Computer Science, University of Padova",
  printable: true,
)

// ── Cover ──────────────────────────────────────────────────────────────────
#cover(
  supervisor-title: "Prof.",
  supervisor-name: "Supervisor Name",
  graduand-name: "Your Name",
  university-id: "0000000",
  thesis-title: "Your Thesis Title",
  academic-year: "2024-2025",
  department: [Dipartimento di Matematica 'Tullio Levi-Civita'],
  degree: [Informatica],
  degree-type: "bachelor", // "bachelor" | "master"
)

// ── Preface ────────────────────────────────────────────────────────────────
#show: preface

#copyright(
  graduand-name: "Your Name",
  thesis-title: "Your Thesis Title",
)

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

// ── Main content ───────────────────────────────────────────────────────────
#show: main

= Introduction

Write your introduction here. Use #acr("API") to reference acronyms and
#gls("example-term") to reference glossary terms.

== Background

Add chapters as needed.

// ── Back matter ────────────────────────────────────────────────────────────

= Glossario

#print-glossary()

= Acronimi

#print-acronyms()
