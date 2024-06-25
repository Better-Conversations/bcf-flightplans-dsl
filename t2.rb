require_relative './t3'

module_3 = FlightPlan.new do
  module_title "Context"
  module_number 3

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

p module_3
