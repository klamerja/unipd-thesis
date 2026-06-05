#import "i18n.typ": t
#import "metadata.typ": _printable, _thesis-title, _author, _supervisor, _university-id, _academic-year, _department, _degree, _degree-type

#let cover() = context {
  let printable = _printable.get()
  let thesis-title = _thesis-title.get()
  let graduand-name = _author.get()
  let supervisor = _supervisor.get()
  let university-id = _university-id.get()
  let academic-year = _academic-year.get()
  let department = _department.get()
  let degree = _degree.get()
  let degree-type = _degree-type.get()

  set page(numbering: none, margin: (x: 3.5cm, y: 4cm))
  set par(first-line-indent: 0pt)

  grid(
    columns: 100%,
    rows: (auto, 1fr, auto),
    row-gutter: 3em,
    align: center,
    [
      #text(size: 18pt, weight: "bold")[#t("unipd")]

      #text(size: 14pt, weight: "medium")[#smallcaps[#department]]

      #text(size: 12pt)[#smallcaps[#t("degree-" + degree-type) #degree]]
    ],
    align(center + horizon)[

      #figure(numbering: none)[
        #image("./assets/unipd-logo.png", height: 6cm)
      ]

      #v(3em)

      #text(size: 18pt, weight: "extrabold", hyphenate: false)[
        #set par(justify: false)
        #thesis-title
      ]

      #text(size: 14pt)[#t("thesis-label" + if degree-type == "master" { "-master" } else { "" })]

      #v(5em)

      #grid(
        columns: (1fr, 1fr),
        align: (left + top, right + top),
        text(size: 12pt)[
          *#t("supervisor")*

          #smallcaps[#supervisor]
        ],
        text(size: 12pt)[
          *#t("graduand")*

          #smallcaps[#graduand-name]

          #smallcaps[#t("student-id")] #university-id
        ],
      )
    ],
    [
      #line(length: 80%, stroke: 0.5pt)

      #smallcaps[#t("academic-year") #academic-year]
    ],
  )

  if printable { pagebreak(to: "odd") } else { pagebreak() }
}
