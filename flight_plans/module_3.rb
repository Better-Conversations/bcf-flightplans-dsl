require_relative '../bcf'
require_relative './common_blocks'

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

  block(BCF::CommonBlocks::PRE_FLIGHT)

  block(lead_by: [:fx1, :fx2]) do
    name "Greeting"
    length 5

    facilitator do
      instruction "Greet people as they join – this is a chance to check their audio/video"
    end

    producer do
      instruction "Setup template Breakout Room for first breakout"
    end
  end

  block(lead_by: :fx1) do
    name "Welcome"
    length 2

    resources do
      flipchart(:flip_1, "Agenda")
    end

    facilitator do
      instruction "Welcome people and introduce facilitator(s), producer and any observers and briefly explain their roles."
      spoken "Last time we looked at how quickly and easily we make assumptions, without being aware of them. We will do a quick review of that soon."
      spoken "Then we will begin to explore the context around a conversation. #bcf-mod[Context helps us make meaning of the world, and determines what assumptions we make.]"

      instruction "Go through agenda on flip"
    end
  end

  block(lead_by: :fx1) do
    name "Any Questions?"
    length 2

    facilitator do
      spoken "And is there anything you need to tell us before we begin? For example, if you need to leave early or if you are having any problems with Zoom."
      spoken "#bcf-mod[And do you have anything you’d like to ask us about today’s topic?]"

      instruction "Respond to any questions/insights but keep it brief."
      instruction "Handover to Fx2 for state check-in."
    end
  end
end

module_3.render_pdf('module_3.pdf', "module_3.typ")
