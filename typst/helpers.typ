#let bcf-nom(body) = highlight(fill: yellow, body)
#let bcf-mod(body) = highlight(fill: green, body)
#let bcf-atten(body) = text(weight: "bold", body)
#let bcf-cue(body) = highlight(fill: rgb(0, 255, 255), text(weight: "bold", body))
#let bcf-fixed = bcf-cue

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
