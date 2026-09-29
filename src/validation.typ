#let _invalid-type(path, expected, value) = {
  panic("invalid `" + path + "`: expected " + expected + ", found " + str(type(value)))
}

#let _expect-dictionary(value, path) = {
  if type(value) != dictionary {
    _invalid-type(path, "a dictionary", value)
  }
}

#let _expect-bool(value, path) = {
  if type(value) != bool {
    _invalid-type(path, "a boolean", value)
  }
}

#let _expect-array(value, path) = {
  if type(value) != array {
    _invalid-type(path, "an array", value)
  }
}

#let _expect-string(value, path, allow-empty: false) = {
  if type(value) != str {
    _invalid-type(path, "a string", value)
  }

  if not allow-empty and value.trim() == "" {
    panic("invalid `" + path + "`: the string must not be empty")
  }
}

#let _expect-content(value, path) = {
  if type(value) != content and type(value) != str {
    _invalid-type(path, "content or a string", value)
  }

  if type(value) == str and value.trim() == "" {
    panic("invalid `" + path + "`: the string must not be empty")
  }
}

#let _expect-length(value, path) = {
  if type(value) != length {
    _invalid-type(path, "a length", value)
  }
}

#let _required-field(dictionary, path, key) = {
  let field-path = path + "." + key

  if not dictionary.keys().contains(key) {
    panic("missing required field `" + field-path + "`")
  }

  dictionary.at(key)
}

#let validate-thesis-profile(profile) = {
  _expect-dictionary(profile, "profile")

  let name = _required-field(profile, "profile", "name")
  let page-margin = _required-field(profile, "profile", "page-margin")
  let cover-margin = _required-field(profile, "profile", "cover-margin")
  let font = _required-field(profile, "profile", "font")
  let heading-font = _required-field(profile, "profile", "heading-font")
  let text-size = _required-field(profile, "profile", "text-size")
  let leading = _required-field(profile, "profile", "leading")
  let paragraph-spacing = _required-field(profile, "profile", "paragraph-spacing")
  let first-line-indent = _required-field(profile, "profile", "first-line-indent")

  _expect-string(name, "profile.name")
  _expect-dictionary(page-margin, "profile.page-margin")
  _expect-dictionary(cover-margin, "profile.cover-margin")
  _expect-string(font, "profile.font")
  _expect-string(heading-font, "profile.heading-font")
  _expect-length(text-size, "profile.text-size")
  _expect-length(leading, "profile.leading")
  _expect-length(paragraph-spacing, "profile.paragraph-spacing")
  _expect-length(first-line-indent, "profile.first-line-indent")

  for side in ("top", "bottom", "left", "right") {
    _expect-length(
      _required-field(page-margin, "profile.page-margin", side),
      "profile.page-margin." + side,
    )
  }

  for axis in ("x", "y") {
    _expect-length(
      _required-field(cover-margin, "profile.cover-margin", axis),
      "profile.cover-margin." + axis,
    )
  }

  profile
}

#let validate-acronyms(acronyms) = {
  _expect-dictionary(acronyms, "acronyms")

  for (key, definition) in acronyms {
    _expect-string(key, "acronyms key")
    _expect-content(definition, "acronyms." + key)
  }

  acronyms
}

#let validate-glossary(glossary) = {
  _expect-array(glossary, "glossary")
  let seen = ()
  let duplicate-keys = ()

  for (index, term) in glossary.enumerate() {
    let path = "glossary[" + str(index) + "]"
    _expect-dictionary(term, path)

    let key = _required-field(term, path, "key")
    let display-name = _required-field(term, path, "display_name")
    let description = _required-field(term, path, "description")
    _expect-string(key, path + ".key")
    _expect-content(display-name, path + ".display_name")
    _expect-content(description, path + ".description")

    if seen.contains(key) and not duplicate-keys.contains(key) {
      duplicate-keys.push(key)
    }
    seen.push(key)
  }

  if duplicate-keys.len() > 0 {
    let label = if duplicate-keys.len() == 1 { "key" } else { "keys" }
    let keys = duplicate-keys.map(key => repr(key)).join(", ")
    panic("duplicate glossary " + label + ": " + keys)
  }

  glossary.sorted(key: it => it.at("key"))
}

#let validate-thesis-config(metadata, lang, printable, document-date) = {
  _expect-string(lang, "lang")
  if not ("it", "en").contains(lang) {
    panic("invalid `lang`: expected `\"it\"` or `\"en\"`, found " + repr(lang))
  }

  _expect-bool(printable, "printable")

  if document-date == none {
    panic("missing required parameter `document-date`: provide a fixed `datetime(...)` for reproducible PDF metadata")
  }

  if type(document-date) != datetime {
    _invalid-type("document-date", "a datetime", document-date)
  }

  _expect-dictionary(metadata, "metadata")

  let title = _required-field(metadata, "metadata", "title")
  let author = _required-field(metadata, "metadata", "author")
  let supervisors = _required-field(metadata, "metadata", "supervisors")
  let academic-year = _required-field(metadata, "metadata", "academic-year")
  let department = _required-field(metadata, "metadata", "department")
  let degree = _required-field(metadata, "metadata", "degree")
  let degree-type = _required-field(metadata, "metadata", "degree-type")

  _expect-string(title, "metadata.title")
  _expect-dictionary(author, "metadata.author")
  _expect-array(supervisors, "metadata.supervisors")
  _expect-string(academic-year, "metadata.academic-year")
  _expect-content(department, "metadata.department")
  _expect-content(degree, "metadata.degree")
  _expect-string(degree-type, "metadata.degree-type")

  let author-name = _required-field(author, "metadata.author", "name")
  let student-id = _required-field(author, "metadata.author", "student-id")
  _expect-string(author-name, "metadata.author.name")
  _expect-string(student-id, "metadata.author.student-id")

  if author.keys().contains("label") {
    _expect-content(author.at("label"), "metadata.author.label")
  }

  if supervisors.len() == 0 {
    panic("invalid `metadata.supervisors`: expected at least one supervisor")
  }

  for (index, supervisor) in supervisors.enumerate() {
    let path = "metadata.supervisors[" + str(index) + "]"
    _expect-dictionary(supervisor, path)

    let role = _required-field(supervisor, path, "role")
    let name = _required-field(supervisor, path, "name")
    _expect-string(role, path + ".role")
    _expect-string(name, path + ".name")

    if not ("supervisor", "co-supervisor").contains(role) {
      panic("invalid `" + path + ".role`: expected `\"supervisor\"` or `\"co-supervisor\"`, found " + repr(role))
    }

    if supervisor.keys().contains("title") {
      _expect-string(supervisor.at("title"), path + ".title", allow-empty: true)
    }

    if supervisor.keys().contains("department") {
      _expect-content(supervisor.at("department"), path + ".department")
    }
  }

  if not ("bachelor", "master").contains(degree-type) {
    panic("invalid `metadata.degree-type`: expected `\"bachelor\"` or `\"master\"`, found " + repr(degree-type))
  }

  if metadata.keys().contains("description") {
    _expect-string(metadata.at("description"), "metadata.description", allow-empty: true)
  }

  metadata
}
