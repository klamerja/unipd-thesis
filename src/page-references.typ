#let _first-occurrence-per-page(occurrences) = {
  let seen-pages = ()
  let unique = ()

  for occurrence in occurrences {
    let page = occurrence.at("global")
    if not seen-pages.contains(page) {
      seen-pages.push(page)
      unique.push(occurrence)
    }
  }

  unique
}

#let page-links(occurrences) = {
  _first-occurrence-per-page(occurrences)
    .map(occurrence => link(
      occurrence.at("location"),
      [#occurrence.at("local")],
    ))
    .join([, ])
}
