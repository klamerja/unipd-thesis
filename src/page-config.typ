#import "i18n.typ": _lang, t
#import "metadata.typ": _metadata, _printable, _profile, _document-date, _recto-break, _is-blank-page
#import "profiles.typ": default-profile
#import "validation.typ": validate-thesis-config, validate-thesis-profile

#let _heading-label(target) = {
  if target.numbering == none { return target.body }
  numbering(target.numbering, ..counter(heading).at(target.location())) + h(0.8em) + target.body
}

// Chapter-opening pages and the blank pages left before a section carry no header.
#let _page-kind(current) = {
  if query(heading.where(level: 1)).any(chapter => chapter.location().page() == current) { "opening" } else if _is-blank-page(current) { "blank" } else { "body" }
}

// Book convention: the left-hand page names the chapter, the right-hand page the current section.
// Both sit against the outer margin.
#let _running-header() = context {
  let current = here().page()
  let previous-chapters = query(heading.where(level: 1).before(here()))
  if _page-kind(current) != "body" or previous-chapters.len() == 0 { return }

  let chapter = previous-chapters.last()
  let label = if calc.even(current) {
    let number = if chapter.numbering != none { t("chapter") + " " + counter(heading).at(chapter.location()).map(str).join(".") + ". " }
    upper[#number#chapter.body]
  } else {
    let on-page = query(heading.where(level: 2)).filter(section => section.location().page() == current)
    let before = query(heading.where(level: 2).after(chapter.location()).before(here()))
    let section = if on-page.len() > 0 { on-page.first() } else if before.len() > 0 { before.last() } else { chapter }
    _heading-label(section)
  }

  set text(size: 9pt)
  set align(if calc.even(current) { left } else { right })
  label
  v(-0.55em)
  line(length: 100%, stroke: 0.4pt)
}

// Page numbers are centred and omitted on blank filler pages.
#let _page-footer() = context {
  let current = here().page()
  if page.numbering == none or _is-blank-page(current) { return }
  align(center, counter(page).display(page.numbering))
}

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

  set page(paper: "a4", margin: profile.at("page-margin"), footer: _page-footer())

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
      let outline-only = (fill: white, stroke: 1pt + accent)
      block(below: 2.8em, text(size: 140pt, ..outline-only)[#counter(heading).display()])
    }
    block(width: 85%, text(size: 36pt, weight: "medium", par(leading: 0.4em, it.body)))
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

#let main(body) = {
  counter(page).update(1)
  set page(numbering: "1.", header: _running-header())

  counter(heading).update(0)
  set heading(outlined: true, numbering: "1.1")

  show heading.where(level: 1): it => {
    _recto-break()
    it
  }

  body
}

#let back-matter(body) = {
  set page(header: none)
  set heading(numbering: none)

  show heading.where(level: 1): it => {
    _recto-break()
    it
  }

  body
}
