#import "i18n.typ": _lang

#let thesis-config(
  title: str,
  author: str,
  description: str,
  printable: bool,
  lang: "it",
  content,
) = {
  _lang.update(lang)

  set document(date: datetime.today(), author: author, title: title, description: description)

  show link: it => {
    if (type(it.dest) == str) {
      set text(fill: rgb("#990001"))
      it
    } else {
      set text(fill: rgb("#0080FF"))
      it
    }
  }

  set page(paper: "a4", number-align: center, margin: (
    top: 3.5cm,
    bottom: 3.5cm,
    left: 4cm,
    right: 4cm,
  ))

  set text(lang: lang, size: 10pt, font: "New Computer Modern")

  set par(
    leading: 0.55em,
    spacing: 1em,
    first-line-indent: 1.8em,
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

  show heading.where(level: 1): it => context {
    v(4em)
    if (it.numbering != none) {
      stack(
        spacing: 1.5em,
        rect(fill: rgb("#9b0014"), inset: 15pt)[
          #align(center + horizon)[
            #text(size: 50pt, weight: "light", fill: luma(255))[
              #counter(heading).display()
            ]
          ]
        ],
        text(size: 28pt, weight: "bold")[#it.body],
      )
    } else {
      block(text(size: 28pt, weight: "bold")[#it.body])
    }
    v(3em)
  }

  show heading.where(level: 2): it => {
    set text(size: 15pt, weight: "bold")
    v(5pt)
    it
    v(5pt)
  }

  show heading.where(level: 3): set text(size: 12pt, weight: "bold")

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
  set page(numbering: "1.")

  counter(heading).update(0)
  set heading(outlined: true, numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  body
}
