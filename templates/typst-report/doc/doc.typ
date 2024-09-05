#import "/constants.typ": *
#import "/lib.typ": *

// SETUP

#set page(
  paper: "a4",
  numbering: "1",
  number-align: right + top
)

#set heading(numbering: "1.")

#show heading.where(level: 1): it => [
  #set text(size: HEADING_SIZE, weight: "bold")
  #it
]

#show heading.where(level: 2): it => [
  #set text(size: SUBHEADING_SIZE, weight: "regular", style: "italic")
  #it
]

#show heading.where(level: 3): it => [
  #set text(size: SUBSUBHEADING_SIZE, weight: "regular", style: "normal")
  #it
]

#show outline: it => {
  set par(leading: 1em)
  it
}

#set figure(placement: none)

#set block(above: 1.5em)

#set par(justify: true)

#set text(size: TEXT_SIZE, font: TEXT_FONT)

#set list(indent: LIST_INDENT)

#set terms(indent: LIST_INDENT)

#show math.equation: set text(size: MATH_SIZE)

#show link: it => {
  set text(fill: blue)
  underline(it)
}

#set list(indent: LIST_INDENT)
#set enum(indent: LIST_INDENT)

#show figure: set block(breakable: false)

#show table.cell.where(y: 0): set text(weight: "bold")
#set table(
  align: (x, y) => if y == 0 { center + horizon } else { center + top },
  stroke: (x, y) => (
    top: if y <= 1 { 0.8pt } else { 0pt },
    bottom: 1pt,
  ),
  inset: 0.5em,
)

// CONTENT

#let date = datetime(
  year: 1970,
  month: 1,
  day: 1,
)

#align(center, [
  #text(size: TITLE_SIZE)[*Title*] \
  \
  #text(size: SUBTITLE_SIZE)[
    Subtitle \
    #date.display("[day] [month repr:long], [year]")
  ]
])

#outline(indent: auto)

#stick-together(
  [= Section 1],
  [#lorem(30) @example-1970]
)

#figure(
  caption: lorem(5),
  table(
      columns: 3,
      table.header[Header 1][Header 2][#lorem(16)],
      [1], [2], [3], [4], [5], lorem(32)
    ),
)

#stick-together(
  [== Subsection],
  [
    #display-question[What is $1 + 1$?]

    #lorem(30)
  ]
)

#stick-together(
  threshold: 10em,
  [=== Subsubsection],
  [
    #display-code(lang: "c", "#include <stdio.h>

    int main() {
      printf(\"Hello, world!\\n\");
      return 0;
    }")

    #lorem(30)
  ]
)

#bibliography("/references.bib")
