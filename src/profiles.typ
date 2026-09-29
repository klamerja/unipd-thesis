#let thesis-profile(
  name: "custom",
  page-margin: (
    top: 3.5cm,
    bottom: 3.5cm,
    left: 4cm,
    right: 4cm,
  ),
  cover-margin: (x: 3.5cm, y: 4cm),
  font: "New Computer Modern",
  heading-font: "EB Garamond",
  text-size: 10pt,
  leading: 0.55em,
  paragraph-spacing: 1em,
  first-line-indent: 1.8em,
) = (
  name: name,
  page-margin: page-margin,
  cover-margin: cover-margin,
  font: font,
  heading-font: heading-font,
  text-size: text-size,
  leading: leading,
  paragraph-spacing: paragraph-spacing,
  first-line-indent: first-line-indent,
)

#let default-profile = thesis-profile(name: "default")
