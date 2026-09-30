#import "metadata.typ": _recto-break

#let dedication(phrase: content) = {
  set page(numbering: none)
  align(center + horizon)[
    #phrase
  ]

  _recto-break()
}
