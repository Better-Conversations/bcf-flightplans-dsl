require_relative './t3'
require_relative './typst_converter'

module_3 = FlightPlan.new do
  module_title "Context"
  module_number 3
  total_length 60
  initial_time -30

  block do
    name "Welcome"
    length 2

    facilitator do
      instruction "Hey"
      spoken "Hey"
    end

    producer do
      instruction "Hey"
      chat "Hey"
    end
  end

  block do
    name "Introduction"
    length 2

    facilitator do
      instruction "Hey"
      spoken "Hey"
    end

    producer do
      chat "hey 2"
    end
  end
end

File.write(
  'typst/module_3_export.typ',
  module_3.to_typst
)
