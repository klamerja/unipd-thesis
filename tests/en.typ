#import "../lib.typ": *

#let glossary = (
  (
    key: "example-term",
    display_name: [Example term],
    description: [A definition used to verify the English template.],
  ),
)

#let acronyms = (
  "API": [Application Programming Interface],
)

#init-glossary(glossary)
#init-acronyms(acronyms)

#show: thesis-config.with(
  lang: "en",
  printable: true,
  document-date: datetime(year: 2026, month: 9, day: 17),
  metadata: (
    title: "English integration test",
    author: (
      name: "Test Candidate",
      student-id: "0000000",
      label: "Candidate",
    ),
    supervisors: (
      (role: "supervisor", title: "Prof.", name: "First Supervisor"),
      (role: "co-supervisor", title: "Dr.", name: "Second Supervisor"),
      (role: "co-supervisor", title: "Dr.", name: "Third Supervisor"),
      (role: "co-supervisor", title: "Dr.", name: "Fourth Supervisor"),
    ),
    academic-year: "2026-2027",
    department: [Department of Testing],
    degree: [Computer Science],
    degree-type: "master",
  ),
)

#cover()

#show: preface
#copyright()
#summary[This document verifies the English localisation.]
#toc()

#show: main
= Introduction

Use #acr("API") and #gls("example-term").

#show: back-matter
= #glossary-title()
#print-glossary()

= #acronyms-title()
#print-acronyms()
