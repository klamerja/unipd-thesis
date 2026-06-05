#import "i18n.typ": t

#let acknowledgements(quote: "", quote-author: "", body) = {
  set par(first-line-indent: 0pt)
  [
    #align(right)[
      #block(width: 220pt)[
        #set text(hyphenate: false)
        #set par(justify: false)
        _'#quote'_

        — #quote-author
      ]
    ]
    = #t("acknowledgements")
    #set text(style: "italic")
    #body
  ]
  pagebreak(weak: true)
}
