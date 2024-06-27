require_relative '../bcf'

# An example of using inheritance to specialise an object created in this manner
class ConventionalFlightPlan < BCF::FlightPlan
  def initialize(&block)
    @total_length = 60
    @initial_time = -30

    super(&block)
  end
end

module_3 = ConventionalFlightPlan.new do
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

module_3.render_pdf('module_3.pdf', "module_3.typ")
