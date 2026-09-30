#let _metadata = state("unipd-thesis:metadata", (:))
#let _printable = state("unipd-thesis:printable", false)
#let _profile = state("unipd-thesis:profile", (:))
#let _document-date = state("unipd-thesis:document-date", none)

// Printed theses open every section on a right-hand (odd) page; digital ones just start a new page.
#let _recto-break() = context {
  if _printable.get() { pagebreak(weak: true, to: "odd") } else { pagebreak(weak: true) }
}

// The filler pages left by `_recto-break` are the even pages holding no content at all.
#let _is-blank-page(current) = {
  let content = selector.or(par, heading, figure, table, image, raw, math.equation, list, enum, terms)
  _printable.get() and calc.even(current) and not query(content).any(element => element.location().page() == current)
}
