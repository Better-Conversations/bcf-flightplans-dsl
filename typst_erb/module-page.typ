#import "./helpers.typ": *

#let module-page(
  module_name: none,
  module_number: none,
  duration: none,
  facilitators: none,
  producer: none,
  observers: none,
  sponsor: none,
  useful_links: [],
  when: none,
  organisation: none,
) = [
  = Module #(module_number): #(module_name)

  == Overview

  #table(
    rows: 9,
    columns: (auto, auto, 1fr),
    table.cell(colspan: 2, [*Date*]), [#when.display("[day] [month repr:long] [year]")],
    table.cell(colspan: 2, [*Start time*]), [#when.display("[hour padding:zero][minute padding:zero]") UTC],
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

  BOR = breakout rooms, Fx = facilitator, Px = producer

  #bcf-nom[Yellow highlighted text] indicates where names, contact details, examples, timings etc. might need to be changed

  #bcf-mod[Green highlighted text] indicates modifications to the live/master version for the session

  #bcf-atten[Bold text] in time plan draws attention to facilitator script

  #bcf-cue[Bold highlighted text] helps provide cues for producer to paste chat text
]
