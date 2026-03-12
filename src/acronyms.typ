#let acron = state("acronyms", none)
#let page_tracker = state("pages_acr", none)

#let init-acronyms(acronyms) = context {
  let states = (:)
  let counters = (:)
  let keys = acronyms.keys()

  for (acr, def) in acronyms {
    states.insert(acr, def)
  }

  for key in keys {
    counters.insert(key, ())
  }

  acron.update(states.pairs().sorted(key: it => it.at(0)))
  page_tracker.update(counters)
}

#let print-pages(key) = context {
  let pages = page_tracker.get().at(key).dedup()

  let i = 0
  let pages_len = pages.len()
  while i < pages_len {
    if i == pages_len - 1 {
      [#link((page: pages.at(i).at("global"), x: 297pt, y: 421pt), [#pages.at(i).at("local")])]
    } else {
      [#link((page: pages.at(i).at("global"), x: 297pt, y: 421pt), [#pages.at(i).at("local")]), ]
    }
    i += 1
  }
}

#let print-acronyms() = context {
  grid(
    columns: (auto, 1fr),
    align: (top, top),
    row-gutter: 1em,
    column-gutter: 1.5em,
    ..acron
      .get()
      .map(it => (
        [*#it.at(0)* #label(it.at(0))],
        [#it.at(1) #print-pages(it.at(0))],
      ))
      .flatten(),
  )
}

#let acr(key) = context {
  let global_page_number = locate(here()).page()
  let local_page_number = counter(page).at(locate(here()))
  page_tracker.update(counters => {
    let pages = counters.at(key)
    pages.push((global: global_page_number, local: local_page_number.at(0)))
    counters.insert(key, pages)

    return counters
  })

  [#link(label(key), key)]
}
