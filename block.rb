class FlightPlan
  attr_accessor :module_number,
                :module_name,
                :blocks

  def initialize(&block)
    instance_eval &block
  end

  def to_typst
    typst = <<-TYPST
      # Module #{@module_number}: #{@module_name}

      #{blocks.map(&:fx_content).join("\n\n")}
    TYPST

    [].each do

    end
  end
end

module Resources
  FlipChart = Struct.new(:label, :description)
  Chat = Struct.new(:content)
  BreakoutRoom = Struct.new(:name)
  Fieldwork = Struct.new(:label0)
end

class Block
  attr_accessor :length,
                :tags,
                :fx_content,
                :pd_content,
                :resources,
                :leading_facilitator

  def initialize(&block)
    instance_eval &block
  end

  def lead_by(facilitator)
    self.clone.instance_eval do ||
      @leading_facilitator = facilitator
      self
    end
  end

  class << self
    def new(&block)
      super(&block)
    end
  end
end


welcome_block = Block.new do
  @length = 2
  @tags = [:welcome, :settle_emotional_state]
  @fx_content = <<-CONTENT
    Welcome people and introduce facilitator(s), producer and any observers and briefly explain their roles.

    #spoken(
      [Last time we looked at how quickly and easily we make assumptions, without being aware of them. We will do a quick review of that soon.],
      [Then we will begin to explore the context around a conversation. #bcf-mod[Context helps us make meaning of the world, and determines what assumptions we make.]]
    )

    Go through agenda on flip
  CONTENT
end

any_questions_block = Block.new do
  @length = 2
  @tags = [:any_questions, :settle_emotional_state]
  @fx_content = <<-CONTENT
    #spoken(
      [And is there anything you need to tell us before we begin? For example, if you need to leave early or if you are having any problems with Zoom.],
      bcf-mod[And do you have anything you’d like to ask us about today’s topic?]
    )

    Respond to any questions/insights but keep it brief.
    Handover to Fx2 for state check-in.
  CONTENT
end

flight_plan = FlightPlan.new do
  @module_number = 3
  @module_name = "Context"

  @blocks = [
    any_questions_block.lead_by(:fx1)
  ]
end

flight_plan.to_typst