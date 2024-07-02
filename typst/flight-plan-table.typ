#let flight-plan-table(
  ..args
) = [
#show table.cell.where(y: 0): set text(white)
#show table.cell: set par(leading: 1em)
#show table.cell.where(x: 2): set par(leading: 1.25em)

#let speaker-swap(body) = table.cell(colspan: 5, fill: rgb(246, 203, 152), pad(y: 6pt, body))

#table(
  fill: (_, y) => {
    if y == 0 { rgb(93, 187, 168) }
    else { rgb(222,	241,	237) }
  },

  align: (x, y) =>
    if x == 0 or x == 1 { center }
    else { left },

  stroke: white,
  inset: 7pt,

  columns: (1fr, 1fr, 2fr, 6fr, 6fr),
  [Time (Actual)], [Length], [Section], [Facilitator], [Producer],

  ..args
)]
