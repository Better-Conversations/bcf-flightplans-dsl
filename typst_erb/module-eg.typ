#import "template.typ": flight-plan, flight-plan-table
#show: doc => flight-plan(
  module_number: 3,
  module_name: "Context",
  when: datetime(
    year: 2024,
    month: 6,
    day: 19,
    hour: 9,
    minute: 0,
    second: 0,
  ),
  organisation: "Better Conversations Foundation",
  doc
)

== Time Plan

#flight-plan-table(
  //FLIGHT_PLAN_TABLE_ROWS//
)
