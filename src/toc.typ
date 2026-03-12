#import "i18n.typ": t

#let toc() = {
  [
    #[
      #show outline.entry.where(
        level: 1,
      ): set block(above: 1.5em)
      #show outline.entry.where(level: 1): set text(weight: "extrabold")

      #outline(title: [#t("toc")])
    ]
    #pagebreak(weak: true)

    #outline(title: [#t("figures")], target: figure.where(kind: image))

    #v(4em)
    #outline(title: [#t("listings")], target: figure.where(kind: raw))
    #pagebreak(weak: true)

    #outline(title: [#t("tables")], target: figure.where(kind: table))
    #pagebreak(weak: true)
  ]
}
