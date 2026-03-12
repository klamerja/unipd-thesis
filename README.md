# unipd-thesis

A [Typst](https://typst.app) thesis template for students at the **University of Padua**. It supports both **Bachelor** and **Master** degrees and provides a clean, structured document layout that follows academic conventions, with built-in support for Italian and English.

![thumbnail](https://raw.githubusercontent.com/klamerja/unipd-thesis/refs/heads/main/thumbnail.png)

## Getting started

### Via Typst Universe

```typ
#import "@preview/unipd-thesis:0.1.0": *
```

Or initialize a new project from the template:

```sh
typst init @preview/unipd-thesis
```

### Locally

Clone the repository and import `lib.typ` directly:

```typ
#import "lib.typ": *
```

## API reference

### `thesis-config`

The root show rule. Must wrap the entire document.

| Parameter     | Type     | Description                                                   |
| ------------- | -------- | ------------------------------------------------------------- |
| `lang`        | `string` | Document language: `"it"` (Italian) or `"en"` (English)       |
| `author`      | `string` | Author's full name                                            |
| `title`       | `string` | Thesis title                                                  |
| `description` | `string` | Short description used in document metadata                   |
| `printable`   | `bool`   | When `true`, enables print-friendly layout (blank pages etc.) |

### `cover`

Renders the official UNIPD cover page.

| Parameter          | Type      | Description                                           |
| ------------------ | --------- | ----------------------------------------------------- |
| `supervisor-title` | `string`  | Academic title of the supervisor (e.g. `"Prof."`)     |
| `supervisor-name`  | `string`  | Full name of the supervisor                           |
| `graduand-name`    | `string`  | Full name of the student                              |
| `university-id`    | `string`  | Student ID (matricola)                                |
| `thesis-title`     | `string`  | Thesis title displayed on the cover                   |
| `academic-year`    | `string`  | Academic year (e.g. `"2024-2025"`)                    |
| `department`       | `content` | Department name (e.g. `[Dipartimento di Matematica]`) |
| `degree`           | `content` | Degree program name (e.g. `[Informatica]`)            |
| `degree-type`      | `string`  | `"bachelor"` or `"master"`                            |

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

### `copyright`

Renders the copyright page.

| Parameter       | Type     | Description         |
| --------------- | -------- | ------------------- |
| `graduand-name` | `string` | Author's full name  |
| `thesis-title`  | `string` | Title of the thesis |

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

Renders the table of contents. Also includes a list of figures, list of tables, and list of code listings if any are present in the document.

```typ
#toc()
```

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

Inserts a hyperlinked acronym that links back to the acronyms list. Tracks every page where the acronym is used.

```typ
Use #acr("API") to call an endpoint.
```

#### `print-acronyms()`

Prints the full acronym list in a two-column grid, with each entry showing the short form, its definition, and the page numbers where it appears.

```typ
= Acronimi
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

Panics if duplicate keys are detected.

```typ
#let my-glossary = (
  (key: "ml", display_name: [_Machine Learning_], description: [A subfield of AI.]),
)
#init-glossary(my-glossary)
```

#### `gls(key, display: none)`

Inserts a hyperlinked glossary reference. By default the key string is used as the link label; pass `display:` to override it.

```typ
#gls("ml")                          // displays "ml"
#gls("ml", display: [machine learning]) // displays "machine learning"
```

#### `print-glossary()`

Prints the full glossary sorted alphabetically by key, with page references for each term.

```typ
= Glossario
#print-glossary()
```

## Localisation

The template ships with full Italian and English string tables. Set the language in `thesis-config`:

```typ
#show: thesis-config.with(lang: "it", ...)  // Italian (default)
#show: thesis-config.with(lang: "en", ...)  // English
```

Localised strings include section headings (acknowledgements, abstract, table of contents, etc.), cover page labels (supervisor, student ID, academic year), and degree type labels.

## License

MIT — see [LICENSE](LICENSE).
