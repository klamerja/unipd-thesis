#import "i18n.typ": t

#let cover(
  supervisor-title: str,
  supervisor-name: str,
  thesis-title: str,
  graduand-name: str,
  university-id: str,
  academic-year: str,
  department: content,
  degree: content,
  degree-type: "bachelor",
) = {
  set page(paper: "a4", number-align: center, numbering: none, margin: (x: 3.5cm, y: 4cm))
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

      #align(left)[
        #text(size: 12pt)[
          *#t("supervisor")*

          #smallcaps[#supervisor-title #supervisor-name]
        ]
      ]

      #align(right)[
        #text(size: 12pt)[
          *#t("graduand")*

          #smallcaps[#graduand-name]

          #smallcaps[#t("student-id")] #university-id
        ]
      ]
    ],
    [
      #line(length: 80%, stroke: 0.5pt)

      #smallcaps[#t("academic-year") #academic-year]
    ],
  )

  pagebreak()
}
