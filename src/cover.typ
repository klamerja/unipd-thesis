#import "i18n.typ": t
#import "metadata.typ": _metadata, _printable, _profile

#let _supervisor-name(supervisor) = {
  let title = supervisor.at("title", default: "")
  let name = supervisor.at("name")
  if title == "" { name } else { title + " " + name }
}

#let _supervisor-card(supervisor) = {
  let department = supervisor.at("department", default: none)

  block[
    #set par(justify: false)
    *#t(supervisor.at("role"))*#linebreak()
    #smallcaps[#_supervisor-name(supervisor)]
    #if department != none {
      linebreak()
      text(size: 8.5pt, style: "italic", department)
    }
  ]
}

#let cover() = context {
  let metadata = _metadata.get()
  let printable = _printable.get()
  let profile = _profile.get()
  let thesis-title = metadata.at("title")
  let author = metadata.at("author")
  let graduand-name = author.at("name")
  let graduand-label = author.at("label", default: t("graduand"))
  let university-id = author.at("student-id")
  let supervisors = metadata.at("supervisors")
  let academic-year = metadata.at("academic-year")
  let department = metadata.at("department")
  let degree = metadata.at("degree")
  let degree-type = metadata.at("degree-type")
  let supervisor-count = supervisors.len()
  let supervisor-text-size = if supervisor-count >= 4 {
    8.5pt
  } else if supervisor-count >= 3 {
    9.5pt
  } else {
    11pt
  }
  let supervisor-spacing = if supervisor-count >= 3 { 0.7em } else { 1.2em }

  set page(numbering: none, margin: profile.at("cover-margin"))
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

      #figure(numbering: none, outlined: false)[
        #image("./assets/unipd-new-logo.png", height: 6cm, alt: t("unipd-logo-alt"))
      ]

      #v(3em)

      #text(size: 18pt, weight: "extrabold", hyphenate: false)[
        #set par(justify: false)
        #thesis-title
      ]

      #text(size: 14pt)[#t("thesis-label" + if degree-type == "master" { "-master" } else { "" })]

      #v(4em)

      #grid(
        columns: (1fr, 1fr),
        align: (left + top, right + top),
        column-gutter: 2em,
        text(size: supervisor-text-size)[
          #stack(
            spacing: supervisor-spacing,
            ..supervisors.map(supervisor => _supervisor-card(supervisor)),
          )
        ],
        text(size: supervisor-text-size)[
          #set par(justify: false)
          *#graduand-label*
          #linebreak()
          #smallcaps[#graduand-name]
          #linebreak()
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
