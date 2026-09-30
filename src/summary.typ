#import "i18n.typ": t
#import "metadata.typ": _recto-break

#let summary(content) = context {
  set par(first-line-indent: 0pt)
  [
    = #t("summary")

    #content

    #_recto-break()
  ]
}
