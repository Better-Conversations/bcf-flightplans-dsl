#import "./module-page.typ": module-page
#import "./flight-plan-table.typ": flight-plan-table

#let spoken(..args) = list(..args.pos().map(arg => text(weight: "bold", arg)))
#let chat(comment: "" ,body) = box(
  fill: rgb(93, 187, 168).lighten(20%),
  radius: 10pt,
  pad(10pt, [
    #{if comment == "" {[=== Copy to chat]} else {[=== Copy to chat #comment:]}}

    #body
  ])
)
#let speaker-swap(body) = table.cell(colspan: 5, fill: rgb(246, 203, 152), pad(y: 6pt, body))

#let instruction(body) = body

#let flight-plan(
  module_number: none,
  module_name: none,
  duration: 60,
  facilitators: (),
  producer: [],
  observers: (),
  sponsor: [],
  when: none,
  organisation: none,
  doc,
) = {
    // Styling, as true to the original word document as possible
  set page(
    flipped: true,
    margin: (x: 1.27cm, y: 1.27cm),
  )

  set text(font: "Source Sans Pro", size: 12pt)
  show heading: set text(navy)

  show heading.where(
    level: 1
  ): it => text(
    rgb("#3E9382"),
    size: 16pt,
    weight: "bold",
    it
  )

  show heading.where(
    level: 2
  ): it => text(
    rgb("#296257"),
    size: 14pt,
    weight: "regular",
    it
  )

  show link: it => underline(text(rgb("#5CB8A5"), it))

  // Begin content

  include "./0-front-page.typ"
  pagebreak()
  module-page(
    module_name: module_name,
    module_number: module_number,
    duration: duration,
    facilitators: facilitators,
    producer: producer,
    observers: observers,
    sponsor: sponsor,
    when: when,
    organisation: organisation,
  )
  pagebreak()

  doc
}
