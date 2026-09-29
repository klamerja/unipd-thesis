#import "i18n.typ": _lang
#import "metadata.typ": _metadata, _printable, _profile, _document-date
#import "profiles.typ": default-profile
#import "validation.typ": validate-thesis-config, validate-thesis-profile

#let thesis-config(
  metadata: (:),
  printable: false,
  lang: "it",
  profile: default-profile,
  document-date: none,
  content,
) = {
  let metadata = validate-thesis-config(metadata, lang, printable, document-date)
  let profile = validate-thesis-profile(profile)
  let title = metadata.at("title")
  let author = metadata.at("author").at("name")
  let description = metadata.at("description", default: "")

  _lang.update(lang)
  _metadata.update(metadata)
  _printable.update(printable)
  _profile.update(profile)
  _document-date.update(document-date)

  set document(date: document-date, author: author, title: title, description: description)

  show link: it => {
    if (type(it.dest) == str) {
      set text(fill: rgb("#990001"))
      it
    } else {
      set text(fill: rgb("#0080FF"))
      it
    }
  }

  set page(paper: "a4", number-align: center, margin: profile.at("page-margin"))

  set text(lang: lang, size: profile.at("text-size"), font: profile.at("font"))

  set par(
    leading: profile.at("leading"),
    spacing: profile.at("paragraph-spacing"),
    first-line-indent: profile.at("first-line-indent"),
    justify: true,
  )

  set list(
    indent: 1.2em,
    body-indent: 0.2em,
    spacing: 1em,
  )

  set enum(
    indent: 1.2em,
    body-indent: 0.2em,
    spacing: 1em,
  )

  show list: it => {
    block()[
      #it
    ]
  }

  show enum: it => {
    block()[
      #it
    ]
  }

  set heading(numbering: "1.1")

  let accent = rgb("#9b0014")

  show heading: set text(font: profile.at("heading-font"))
  show heading: set par(justify: false)
  show heading: set text(hyphenate: false)

  // Chapters always open on a right-hand page, so the title sits against the outer (right) margin.
  show heading.where(level: 1): it => context {
    set align(right)
    set text(top-edge: "cap-height", bottom-edge: "baseline")
    v(3em)
    if (it.numbering != none) {
      let outline-only = (fill: rgb(0, 0, 0, 0), stroke: 1pt + accent)
      block(below: 2.8em, text(size: 180pt, ..outline-only)[#counter(heading).display()])
    }
    block(width: 85%, par(leading: 0.5em, text(size: 32pt, weight: "medium")[#it.body]))
    v(4em)
  }

  show heading.where(level: 2): it => {
    set text(size: 16pt, weight: "semibold")
    v(5pt)
    it
    v(5pt)
  }

  show heading.where(level: 3): set text(size: 13pt, weight: "semibold")

  show figure: set block(above: 1.5em, below: 1.5em)

  show ref: set text(fill: rgb("#0080FF"))

  content
}

#let preface(body) = {
  counter(page).update(1)
  set page(numbering: "i.")

  set heading(outlined: false, numbering: none)

  body
}

#let main(body) = context {
  let printable = _printable.get()

  counter(page).update(1)
  set page(numbering: "1.")

  counter(heading).update(0)
  set heading(outlined: true, numbering: "1.1")

  show heading.where(level: 1): it => {
    if printable { pagebreak(to: "odd") } else { pagebreak(weak: true) }
    it
  }

  body
}

#let back-matter(body) = context {
  let printable = _printable.get()

  set heading(numbering: none)

  show heading.where(level: 1): it => {
    if printable { pagebreak(to: "odd") } else { pagebreak(weak: true) }
    it
  }

  body
}
