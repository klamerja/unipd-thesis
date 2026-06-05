#import "i18n.typ": t

#let summary(content) = {
  set par(first-line-indent: 0pt)
  [
    = #t("summary")

    #content

    #pagebreak(weak: true)
  ]
}
