#import "i18n.typ": t

#let _include-list(option, target, name) = {
  if option == "auto" {
    query(target).any(item => item.outlined and item.caption != none)
  } else if type(option) == bool {
    option
  } else {
    panic("toc parameter `" + name + "` must be `\"auto\"`, `true`, or `false`")
  }
}

#let toc(figures: "auto", code-blocks: "auto", tables: "auto") = context {
  show outline.entry.where(level: 1): set block(above: 1.5em)
  show outline.entry.where(level: 1): set text(weight: "extrabold")

  outline(title: [#t("toc")])

  let auxiliary-lists = (
    (option: figures, title: t("figures"), target: figure.where(kind: image), name: "figures"),
    (
      option: code-blocks,
      title: t("code-blocks"),
      target: figure.where(kind: raw),
      name: "code-blocks",
    ),
    (option: tables, title: t("tables"), target: figure.where(kind: table), name: "tables"),
  )

  for list in auxiliary-lists {
    if _include-list(list.option, list.target, list.name) {
      pagebreak(weak: true)
      outline(title: list.title, target: list.target)
    }
  }

  pagebreak(weak: true)
}
