#import "metadata.typ": _thesis-title, _author

#let copyright() = context {
  let thesis-title = _thesis-title.get()
  let graduand-name = _author.get()

  let months = (
    "Gennaio",
    "Febbraio",
    "Marzo",
    "Aprile",
    "Maggio",
    "Giugno",
    "Luglio",
    "Agosto",
    "Settembre",
    "Ottobre",
    "Novembre",
    "Dicembre",
  )

  set page(numbering: none)
  align(left + bottom)[
    #graduand-name: #text(style: "italic")[#thesis-title], Tesi di laurea, © #months.at(datetime.today().month() - 1) #datetime.today().year()
  ]
  pagebreak(weak: true)
}
