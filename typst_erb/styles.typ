#import "./flight-plan-table.typ": flight-plan-table
#import "./helpers.typ": *

#let flight-plan(
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

  doc
}

#let info-table(
  date: none,
  time: none,
  duration: none,
  organisation: none,

  module_name: none,
  module_number: none,
  facilitators: (),
  producer: none,
  observers: (),
  sponsor: none,
  useful_links: [],
) = [
  #table(
    rows: 9,
    columns: (auto, auto, 1fr),
    table.cell(colspan: 2, [*Date*]), [#date],
    table.cell(colspan: 2, [*Start time*]), [#time],
    table.cell(colspan: 2, [*Duration*]), [#duration minutes],
    table.cell(colspan: 2, [*Organisation*]), [#organisation],
    table.cell(rowspan: 4, [*Delivery Team*]),
      [*Facilitators*], [
        #(facilitators.join(linebreak()))
      ],
      [*Producer*], [
        #(producer)
      ],
      [*Observers*], [
        #(observers.join(linebreak()))
      ],
      [*Sponsor*], [
        #(sponsor)
      ],
      table.cell(colspan: 2, [*Useful Links*]), [
        #useful_links
      ],
  )
]
