#import "i18n.typ": t
#import "metadata.typ": _metadata, _profile, _recto-break

#let _accent = rgb("#9b0014")

#let _label(key) = text(size: 9pt, tracking: 0.12em, fill: _accent, upper(key))

#let _supervisor-name(supervisor) = {
  let title = supervisor.at("title", default: "")
  let name = supervisor.at("name")
  if title == "" { name } else { title + " " + name }
}

#let _supervisor-card(supervisor, name-size) = {
  let department = supervisor.at("department", default: none)

  stack(
    spacing: 0.9em,
    _label(t(supervisor.at("role"))),
    text(size: name-size, _supervisor-name(supervisor)),
    ..if department != none { (text(size: 10pt, fill: luma(90), department),) },
  )
}

#let cover() = context {
  let metadata = _metadata.get()
  let profile = _profile.get()
  let author = metadata.at("author")
  let supervisors = metadata.at("supervisors")
  let degree-type = metadata.at("degree-type")
  // Strings bypass smart quotes, so the typographic apostrophe is set explicitly.
  let thesis-title = metadata.at("title").replace("'", "’")
  let supervisor-count = supervisors.len()
  let name-size = if supervisor-count >= 4 { 11pt } else { 13pt }
  let supervisor-spacing = if supervisor-count >= 3 { 1.4em } else { 1.8em }

  set page(numbering: none, margin: profile.at("cover-margin"))
  set par(first-line-indent: 0pt, justify: false, leading: 0.75em)
  set text(font: profile.at("heading-font"))

  grid(
    columns: 100%,
    rows: (auto, 1fr, auto),
    align(center)[
      #image("./assets/unipd-new-logo.png", height: 5.5cm, alt: t("unipd-logo-alt"))
      #v(1.4em)
      #text(size: 13pt, tracking: 0.3em, upper(t("unipd")))
      #v(0.2em)
      #text(size: 13pt, par(leading: 0.95em)[#metadata.at("department") \ #t("degree-" + degree-type) #metadata.at("degree")])
    ],
    align(center + horizon)[
      #block(width: 90%, text(size: 30pt, weight: "medium", hyphenate: false, par(leading: 0.4em, thesis-title)))
      #v(1em)
      #line(length: 2.5cm, stroke: 0.8pt + _accent)
      #v(0.8em)
      #text(size: 14pt, t("thesis-label" + if degree-type == "master" { "-master" } else { "" }))
    ],
    [
      #line(length: 100%, stroke: 0.5pt + luma(150))
      #v(1em)
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 2em,
        align: (left + top, right + top),
        stack(spacing: supervisor-spacing, ..supervisors.map(supervisor => _supervisor-card(supervisor, name-size))),
        stack(
          spacing: 0.9em,
          _label(author.at("label", default: t("graduand"))),
          text(size: name-size, author.at("name")),
          text(size: 11pt, fill: luma(90))[#t("student-id") #author.at("student-id")],
        ),
      )
      #v(2.4em)
      #align(center, text(size: 11pt, tracking: 0.15em, fill: _accent)[#upper(t("academic-year")) #metadata.at("academic-year")])
    ],
  )

  _recto-break()
}
