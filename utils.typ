#import "@preview/fontawesome:0.6.0": *

/// #mail
///
/// - email (str): the email address of the author
/// -> (block): a block containing the email address
#let mail(email) = {
  text(size: 1.2em)[#raw(email)]
}

/// 
/// - name (str): the name of the author
/// -> (block): a block containing the name of the author
#let first_author(name) = {
  strong(name)
}

/// #author_list
///
/// - authors (list of tuples): a list of tuples containing names and emails
/// -> (block): a block containing the authors' information
#let author_list(authors, logo: none, width: 35%) = block[
  #table(
    inset: (0em, 0em), column-gutter: 1em, row-gutter: 0.75em, stroke: none, columns: (auto, 4fr), align: (left, left),
    ..authors.map((record) => (record.at(0), mail(record.at(1)))).flatten()
  )
  #if logo != none {
    place(right)[
      #figure(image(logo, width: width))
    ]
  }
  #v(1em)
]

/// #bold
///
/// - content (block): the content to be displayed in bold
/// -> (block): a block containing the bolded content
#let bold(content) = {
  text(weight: "bold")[#content]
}

#let styled-block(
  title, 
  content, 
  icon: "", 
  fill-color: rgb("#1f2937").lighten(90%),
  stroke-color: rgb("#1f2937").lighten(50%),
  title-color: rgb("#292524"),
  title-size: 20pt
) = {
  block(
    width: 100%,
    inset: (x: 24pt, y: 18pt),
    fill: fill-color,
    radius: 8pt,
    stroke: (
      paint: stroke-color, 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: title-size, fill: title-color)[#icon #title]
      #v(-12pt)
      #line(length: 100%, stroke: (paint: stroke-color, thickness: 1.5pt))
      #v(-10pt)
      #content
    ]
  )
}

/// Blocks
#let feature-block(title, content, icon: "") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#ecfdf5"),      // soft mint background
    stroke-color: rgb("#059669"),     // emerald green border
    title-color: rgb("#065f46"),      // deep green title
    title-size: 22pt
  )
}

#let note-block(title, content, icon: fa-info-circle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#dbeafe"),       // soft sky background
    stroke-color: rgb("#3b82f6"),      // blue border
    title-color: rgb("#1e40af"),       // deep blue title
  )
}

#let warning-block(title, content, icon: fa-exclamation-triangle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#fef3c7"),       // soft amber background
    stroke-color: rgb("#f59e0b"),      // amber border
    title-color: rgb("#92400e"),       // deep amber title
  )
}

/// Definition callout box
///
/// - title (str): heading for the box (default "Definizione")
/// - content (content): body content
#let definition-block(title, content, icon: fa-book() + " ") = {
  styled-block(
    title,
    content,
    icon: icon,
    fill-color: rgb("#fce7f3"),       // soft pink background
    stroke-color: rgb("#ec4899"),      // pink border
    title-color: rgb("#9f1239"),       // deep rose title
  )
}

/// Example callout box
///
/// - title (str): heading for the box (default "Esempio")
/// - content (content): body content
#let example-block(title, content, icon: fa-lightbulb() + " ") = {
  styled-block(
    title,
    content,
    icon: icon,
    fill-color: rgb("#fef9c3"),       // soft yellow background
    stroke-color: rgb("#eab308"),      // yellow border
    title-color: rgb("#854d0e"),       // deep yellow title
  )
}

/// Concept/Important callout box
///
/// - title (str): heading for the box (default "Concetto chiave")
/// - content (content): body content
#let concept-block(title, content, icon: fa-star() + " ") = {
  styled-block(
    title,
    content,
    icon: icon,
    fill-color: rgb("#fff7ed"),       // soft orange background
    stroke-color: rgb("#f97316"),      // orange border
    title-color: rgb("#c2410c"),       // deep orange title
  )
}

/// Feature card for AI-assisted capabilities
///
/// - icon (content): FontAwesome icon
/// - title (str): Feature name
/// - description (str): Short description
/// - gradient-from (color): Start color for gradient
/// - gradient-to (color): End color for gradient
/// - stroke-color (color): Border color
/// - title-color (color): Title text color
#let feature-card(
  icon,
  title,
  description,
  gradient-from,
  gradient-to,
  stroke-color,
  title-color
) = {
  block(
    width: 100%,
    inset: 1em,
    fill: gradient.linear(gradient-from, gradient-to),
    radius: 10pt,
    stroke: 2pt + stroke-color,
    [
      #align(center)[
        #text(size: 2.2em)[#icon]
        #v(0.25em)
        #text(size: 1em, weight: "bold", fill: title-color)[#title]
        #v(0.15em)
        #text(size: 0.8em, fill: rgb("#475569"))[#description]
      ]
    ]
  )
}
