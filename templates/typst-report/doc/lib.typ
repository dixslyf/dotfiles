#import "/constants.typ": *
#import "/lib/stick-together.typ": stick-together

#let display-code(content, lang: none, inset: 1em, breakable: false) = align(center, {
  set text(size: CODE_TEXT_SIZE)

  show raw.where(block: true): block.with(
    fill: CODE_BLOCK_BG,
    inset: inset,
    breakable: breakable
  )

  raw(
    lang: lang,
    block: true,
    content
  )
})

#let display-question(content, heading-size: TEXT_SIZE) = align(
  center,
  context {
    let heading = text(size: heading-size, weight: "bold", "Question:")
    let size = measure(heading)
    block(
      breakable: true,
      fill: CODE_BLOCK_BG,
      inset: (
        top: 20pt - (heading-size - size.height),
        right: 20pt,
        bottom: 20pt,
        left: 20pt
      ),
      width: 100%,
      align(
        start,
        stick-together(threshold: 10em, heading, content)
      )
    )
  }
)

