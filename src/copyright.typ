#import "i18n.typ": t, month-name
#import "metadata.typ": _metadata, _document-date, _recto-break

#let copyright() = context {
  let metadata = _metadata.get()
  let document-date = _document-date.get()
  let thesis-title = metadata.at("title")
  let graduand-name = metadata.at("author").at("name")
  let degree-type = metadata.at("degree-type")

  set page(numbering: none)
  align(left + bottom)[
    #graduand-name: #text(style: "italic")[#thesis-title], #t("thesis-label" + if degree-type == "master" { "-master" } else { "" }), © #month-name(document-date.month()) #document-date.year()
  ]
  _recto-break()
}
