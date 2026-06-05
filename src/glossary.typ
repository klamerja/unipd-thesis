#let gloss = state("glossary", none)
#let page_tracker = state("pages_gls", none)

#let init-glossary(glossary) = context {
  let glossary_dedup = glossary.dedup(key: it => it.at("key"))
  if (glossary_dedup.len() != glossary.len()) {
    panic("panik https://tenor.com/bzP9e.gif")
  }

  let counters = (:)

  for term in glossary {
    counters.insert(term.at("key"), ())
  }

  gloss.update(glossary.sorted(key: it => it.at("key")))
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

#let print-glossary() = context {
  set par(first-line-indent: 0pt, hanging-indent: 1.2em, spacing: 1.5em)
  for elem in gloss.get() {
    [
      *#elem.display_name*: #elem.description #label(elem.key) #print-pages(elem.key)

    ]
  }
}

#let gls(key, display: none) = context {
  let global_page_number = locate(here()).page()
  let local_page_number = counter(page).at(locate(here()))
  page_tracker.update(counters => {
    let pages = counters.at(key)
    pages.push((global: global_page_number, local: local_page_number.at(0)))
    counters.insert(key, pages)

    return counters
  })

  if (display != none) {
    [#link(label(key), display)]
  } else {
    [#link(label(key), [#key])]
  }
}
