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
  fill-color: rgb("#23373b").lighten(90%),
  stroke-color: rgb("#23373b").lighten(50%),
  title-color: rgb("#000000"),
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
    fill-color: rgb("#f0f9ff"),      // soft blue background
    stroke-color: rgb("#0ea5e9"),     // sky blue border
    title-color: rgb("#0c4a6e"),      // deep blue title
    title-size: 22pt
  )
}

#let note-block(title, content, icon: fa-info-circle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#ecfdf5"),       // soft mint background
    stroke-color: rgb("#10b981"),      // emerald border
    title-color: rgb("#065f46"),       // deep green title
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
    fill-color: rgb("#ede9fe"),       // soft purple background
    stroke-color: rgb("#8b5cf6"),      // violet border
    title-color: rgb("#5b21b6"),       // deep purple title
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
    fill-color: rgb("#dcfce7"),       // soft lime background
    stroke-color: rgb("#22c55e"),      // green border
    title-color: rgb("#15803d"),       // deep green title
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
    stroke-color: rgb("#fb923c"),      // orange border
    title-color: rgb("#c2410c"),       // deep orange title
  )
}
