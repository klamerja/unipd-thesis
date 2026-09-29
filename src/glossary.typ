#import "page-references.typ": page-links
#import "i18n.typ": t
#import "validation.typ": validate-glossary

#let gloss = state("unipd-thesis:glossary", none)
#let page_tracker = state("unipd-thesis:glossary-pages", none)

#let _target(key) = label("unipd-thesis-glossary-" + key)

#let _require-registry() = {
  let entries = gloss.get()
  let counters = page_tracker.get()

  if entries == none or counters == none {
    panic("glossary registry is not initialized; call `init-glossary(...)` first")
  }

  (entries: entries, counters: counters)
}

#let _require-key(key) = {
  if type(key) != str {
    panic("invalid glossary key: expected a string, found " + str(type(key)))
  }

  let registry = _require-registry()
  if not registry.counters.keys().contains(key) {
    panic("unknown glossary key " + repr(key) + "; add it to the array passed to `init-glossary(...)`")
  }

  registry
}

#let init-glossary(glossary) = context {
  let glossary = validate-glossary(glossary)

  let counters = (:)

  for term in glossary {
    counters.insert(term.at("key"), ())
  }

  gloss.update(glossary)
  page_tracker.update(counters)
}

#let glossary-title() = context t("glossary")

#let print-pages(key) = context {
  page-links(_require-key(key).counters.at(key))
}

#let print-glossary() = context {
  let registry = _require-registry()

  set par(first-line-indent: 0pt, hanging-indent: 1.2em, spacing: 1.5em)
  for elem in registry.entries {
    [
      *#elem.display_name*: #elem.description #_target(elem.key) #print-pages(elem.key)

    ]
  }
}

#let gls(key, display: none) = context {
  let registry = _require-key(key)

  let occurrence = here()
  let global_page_number = occurrence.page()
  let local_page_number = counter(page).at(occurrence)
  page_tracker.update(counters => {
    let pages = counters.at(key)
    pages.push((
      location: occurrence,
      global: global_page_number,
      local: local_page_number.at(0),
    ))
    counters.insert(key, pages)

    return counters
  })

  if (display != none) {
    [#link(_target(key), display)]
  } else {
    [#link(_target(key), [#key])]
  }
}
