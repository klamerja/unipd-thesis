# unipd-thesis 🎓

An independent, community-maintained [Typst](https://typst.app) thesis template for students at the **University of Padua**. It supports both **Bachelor** and **Master** degrees, with built-in Italian and English localisation. This is not an official, approved, or endorsed University template; always check the rules of your degree programme or department.

![thumbnail](https://raw.githubusercontent.com/klamerja/unipd-thesis/refs/heads/main/thumbnail.png)

## Getting started

Clone the repository and import `lib.typ` directly from your thesis project:

```typ
#import "lib.typ": *
```

## API reference

### `thesis-config`

The root show rule. It must wrap the entire document and receives all thesis metadata through one `metadata` dictionary.

| Parameter   | Type         | Description                                                    |
| ----------- | ------------ | -------------------------------------------------------------- |
| `metadata`  | `dictionary` | Thesis, author, course, and cover metadata                      |
| `lang`      | `string`     | Document language: `"it"` (Italian) or `"en"` (English)        |
| `printable` | `bool`       | When `true`, enables print-friendly layout (blank pages etc.)  |
| `profile`   | `dictionary` | Optional typography and margin profile; defaults to `default-profile` |
| `document-date` | `datetime`   | Required fixed creation date for reproducible PDF metadata          |

The `metadata` dictionary contains:

| Field           | Type         | Description                                      |
| --------------- | ------------ | ------------------------------------------------ |
| `title`         | `string`     | Thesis title                                     |
| `author`        | `dictionary` | `name`, `student-id`, and optional cover `label` |
| `supervisors`   | `array`      | One or more supervisor dictionaries              |
| `academic-year` | `string`     | Academic year, for example `"2026-2027"`         |
| `department`    | `content`    | Department name                                  |
| `degree`        | `content`    | Degree programme name                            |
| `degree-type`   | `string`     | `"bachelor"` or `"master"`                      |
| `description`   | `string`     | Optional description used in the PDF metadata    |

All fields except `description` are required. The template validates the configuration before rendering and reports the complete path of any missing or invalid field, such as `metadata.author.student-id`.

```typ
#show: thesis-config.with(
  lang: "it",
  printable: true,
  document-date: datetime(year: 2026, month: 1, day: 1),
  metadata: (
    title: "Your Thesis Title",
    author: (
      name: "Your Name",
      student-id: "0000000",
      label: "Laureanda", // Optional cover label.
    ),
    supervisors: (
      (
        role: "supervisor",
        title: "Prof.",
        name: "Supervisor Name",
      ),
      (
        role: "co-supervisor",
        title: "Dr.",
        name: "Co-supervisor Name",
        department: [Department of the Co-supervisor],
      ),
    ),
    academic-year: "2026-2027",
    department: [Dipartimento di Matematica 'Tullio Levi-Civita'],
    degree: [Informatica],
    degree-type: "bachelor",
    description: "BSc thesis in Computer Science, University of Padua",
  ),
)
```

`document-date` is required because PDF/A requires a creation date. It is also used for the month and year on the copyright page. Always use a fixed value so rebuilding the same sources does not introduce the current date into the output:

```typ
#show: thesis-config.with(
  document-date: datetime(year: 2026, month: 9, day: 16),
  metadata: (...),
)
```

Avoid `datetime.today()`: it changes with the build environment and makes the PDF metadata non-reproducible.

Each supervisor dictionary accepts:

| Field        | Type      | Required | Description                                      |
| ------------ | --------- | -------- | ------------------------------------------------ |
| `role`       | `string`  | yes      | `"supervisor"` or `"co-supervisor"`              |
| `name`       | `string`  | yes      | Full name without the academic title             |
| `title`      | `string`  | no       | Academic title, for example `"Prof."` or `"Dr."` |
| `department` | `content` | no       | Department shown below the person's name         |

The optional `metadata.author.label` replaces the default candidate label on the cover. For example, an Italian thesis can use `label: "Laureanda"`; the default labels are `Laureando` and `Candidate` for Italian and English.

### Department profiles

`thesis-profile` creates a reusable presentation profile for margins and body typography. The package intentionally ships only a neutral `default-profile`: department requirements vary, so a named profile must be checked against the current instructions of the relevant degree programme and must not be treated as certified compliance.

```typ
#let my-department-profile = thesis-profile(
  name: "my-department-2026",
  page-margin: (
    top: 3cm,
    bottom: 3cm,
    left: 3.5cm,
    right: 3cm,
  ),
  cover-margin: (x: 3.5cm, y: 4cm),
  font: "New Computer Modern",
  heading-font: "EB Garamond",
  text-size: 12pt,
  leading: 0.65em,
  paragraph-spacing: 1em,
  first-line-indent: 1.8em,
)

#show: thesis-config.with(
  profile: my-department-profile,
  metadata: (...),
)
```

The profile and all its fields are validated before rendering. Invalid or missing values produce an error that identifies the complete field path.

### `cover`

Renders the UNIPD cover page using the data supplied to `thesis-config`.

```typ
#cover()
```

### `preface`

Show rule that wraps the front matter (pages before the main content). Pages are numbered with roman numerals (`i`, `ii`, …). Headings in this section are unnumbered and excluded from the outline.

```typ
#show: preface
```

### `main`

Show rule that starts the main body of the thesis. Resets the page counter to `1` and re-enables numbered, outlined headings. Each level-1 heading automatically starts on a new page.

```typ
#show: main
```

### `back-matter`

Show rule for unnumbered end matter. Each level-1 heading starts on a new page.

```typ
#show: back-matter
```

### `copyright`

Renders the copyright page using the author and title supplied to `thesis-config`.

```typ
#copyright()
```

---

### `dedication`

Renders a centered dedication page (no page number shown).

| Parameter | Type      | Description                           |
| --------- | --------- | ------------------------------------- |
| `phrase`  | `content` | The dedication text (supports markup) |

### `acknowledgements`

Renders the acknowledgements section with an optional epigraph.

| Parameter      | Type      | Description               |
| -------------- | --------- | ------------------------- |
| `quote`        | `string`  | Epigraph quote text       |
| `quote-author` | `string`  | Author of the epigraph    |
| body           | `content` | The acknowledgements text |

### `summary`

Renders the abstract/summary section. The heading label is localised automatically (`"Sommario"` in Italian, `"Abstract"` in English).

```typ
#summary[Your abstract text here.]
```

### `toc`

Renders the table of contents. Lists of figures, tables, and code blocks are included automatically only when they contain entries.

```typ
#toc()
```

Each auxiliary list accepts `"auto"` (the default), `true`, or `false`:

```typ
#toc(
  figures: "auto",
  tables: true,
  code-blocks: false,
)
```

## PDF/A export

The cover image includes alternative text, so the template can be exported to an accessible PDF/A profile. With the Typst CLI, run:

```sh
typst compile --pdf-standard a-2a index.typ thesis.pdf
```

In the Typst web app, select `PDF/A-2a` in the PDF export settings.

### Acronyms

#### `init-acronyms(acronyms)`

Initialises the acronym registry. Must be called before any use of `#acr()`. Accepts a dictionary mapping short forms to their full definitions.

```typ
#let my-acronyms = (
  "API": [_Application Programming Interface_],
  "UI":  [_User Interface_],
)
#init-acronyms(my-acronyms)
```

#### `acr(key)`

Inserts a hyperlinked acronym that links back to the acronyms list. The first use is expanded automatically, for example _Application Programming Interface_ (`API`); subsequent uses display only `API`. It tracks every page where the acronym is used and reports a clear error if the registry has not been initialized or the requested acronym is undefined. Duplicate acronym keys cannot occur because Typst dictionaries require unique keys.

```typ
Use #acr("API") to call an endpoint.
```

#### `print-acronyms()`

Prints the full acronym list in a two-column grid, with each entry showing the short form, its definition, and the page numbers where it appears.

```typ
= #acronyms-title()
#print-acronyms()
```

### Glossary

#### `init-glossary(glossary)`

Initialises the glossary. Must be called before any use of `#gls()`. Accepts an array of dictionaries, each with:

| Field          | Type      | Description                              |
| -------------- | --------- | ---------------------------------------- |
| `key`          | `string`  | Unique identifier used in `#gls()`       |
| `display_name` | `content` | Term as it should appear in the glossary |
| `description`  | `content` | Definition of the term                   |

Duplicate keys produce an error that lists every duplicated key.

```typ
#let my-glossary = (
  (key: "ml", display_name: [_Machine Learning_], description: [A subfield of AI.]),
)
#init-glossary(my-glossary)
```

#### `gls(key, display: none)`

Inserts a hyperlinked glossary reference. By default the key string is used as the link label; pass `display:` to override it. Reports a clear error if the registry has not been initialized or the requested key is undefined.

```typ
#gls("ml")                          // displays "ml"
#gls("ml", display: [machine learning]) // displays "machine learning"
```

#### `print-glossary()`

Prints the full glossary sorted alphabetically by key, with page references for each term.

```typ
= #glossary-title()
#print-glossary()
```

## Localisation

The template ships with full Italian and English string tables. Set the language in `thesis-config`:

```typ
#show: thesis-config.with(
  lang: "en",
  document-date: datetime(year: 2026, month: 9, day: 17),
  metadata: (...),
)
```

Localised strings include section headings (acknowledgements, abstract, table of contents, etc.), cover page labels (supervisor, student ID, academic year), and degree type labels.

## Project status and trademark notice

This repository is an independent project and is not an official or endorsed University of Padua template. The University publishes its own rules on the [use of its logo and requests for authorization](https://www.unipd.it/patrocini-uso-marchio), as well as the applicable [name, image, and trademark regulations](https://www.unipd.it/node/79418).

The MIT License applies to the project source code, not to the University name, seal, or logo. Permission to redistribute the bundled logo through Typst Universe or another package registry has not been established. See [NOTICE.md](NOTICE.md) before publishing or redistributing the package.

## License

Source code: MIT — see [LICENSE](LICENSE). University trademarks and visual identity assets are excluded; see [NOTICE.md](NOTICE.md).
