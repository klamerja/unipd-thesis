#import "page-references.typ": page-links
#import "i18n.typ": t
#import "validation.typ": validate-acronyms

#let acron = state("unipd-thesis:acronyms", none)
#let page_tracker = state("unipd-thesis:acronym-pages", none)

#let _target(key) = label("unipd-thesis-acronym-" + key)

#let _require-registry() = {
  let entries = acron.get()
  let counters = page_tracker.get()

  if entries == none or counters == none {
    panic("acronym registry is not initialized; call `init-acronyms(...)` first")
  }

  (entries: entries, counters: counters)
}

#let _require-key(key) = {
  if type(key) != str {
    panic("invalid acronym key: expected a string, found " + str(type(key)))
  }

  let registry = _require-registry()
  if not registry.counters.keys().contains(key) {
    panic("unknown acronym " + repr(key) + "; add it to the dictionary passed to `init-acronyms(...)`")
  }

  registry
}

#let init-acronyms(acronyms) = context {
  let acronyms = validate-acronyms(acronyms)
  let states = (:)
  let counters = (:)
  let keys = acronyms.keys()

  for (acr, def) in acronyms {
    states.insert(acr, def)
  }

  for key in keys {
    counters.insert(key, ())
  }

  acron.update(states)
  page_tracker.update(counters)
}

#let print-pages(key) = context {
  page-links(_require-key(key).counters.at(key))
}

#let print-acronyms() = context {
  let registry = _require-registry()

  grid(
    columns: (auto, 1fr),
    align: (top, top),
    row-gutter: 1em,
    column-gutter: 1.5em,
    ..registry
      .entries
      .pairs()
      .sorted(key: it => it.at(0))
      .map(it => (
        [*#it.at(0)* #_target(it.at(0))],
        [#it.at(1) #print-pages(it.at(0))],
      ))
      .flatten(),
  )
}

#let acronyms-title() = context t("acronyms")

#let acr(key) = context {
  let registry = _require-key(key)
  let first-use = registry.counters.at(key).len() == 0

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

  let display = if first-use {
    [#registry.entries.at(key) (#key)]
  } else {
    [#key]
  }

  [#link(_target(key), display)]
}
