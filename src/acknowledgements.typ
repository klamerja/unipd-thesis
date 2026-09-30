#import "i18n.typ": t
#import "metadata.typ": _recto-break

#let acknowledgements(quote: "", quote-author: "", body) = context {
  set par(first-line-indent: 0pt)
  [
    #align(right)[
      #block(width: 220pt)[
        #set text(hyphenate: false)
        #set par(justify: false)
        _'#quote'_

        --- #quote-author
      ]
    ]
    = #t("acknowledgements")
    #set text(style: "italic")
    #body
  ]
  _recto-break()
}
