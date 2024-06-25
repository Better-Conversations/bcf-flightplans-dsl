require 'forwardable'

class FlightPlan
  attr_accessor :module_number,
                :module_title,
                :blocks,
                :total_length

  class DSL
    def initialize(flight_plan, &block)
      @flight_plan = flight_plan
      instance_eval &block
    end

    def module_number(number)
      @flight_plan.module_number = number
    end

    def module_title(title)
      @flight_plan.module_title = title
    end

    def block(block_instance = nil, &block_constructor)
      if block_instance and block_instance.is_a? Block
        @flight_plan.blocks << block_instance
      else
        @flight_plan.blocks << Block.new(&block_constructor)
      end
    end

    def total_length(length)
      @flight_plan.total_length = length
    end
  end

  def initialize(&block)
    @blocks = []
    DSL.new(self, &block)
  end
end

class Block
  attr_accessor :name,
                :length,
                :facilitator_notes,
                :producer_notes

  class DSL
    def initialize(obj, &block)
      @block = obj
      instance_eval &block
    end

    def name(name)
      @block.name = name
    end

    def length(length)
      @block.length = length
    end

    def facilitator(&block)
      @block.facilitator_notes << FacilitatorNotes.new(&block)
    end

    def producer(&block)
      @block.producer_notes << ProducerNotes.new(&block)
    end
  end

  def initialize(&block)
    @facilitator_notes = []
    @producer_notes = []
    DSL.new(self, &block)
  end
end

class Notes
  attr_accessor :items

  def initialize(&block)
    @items = []
    instance_eval &block
  end

  def instruction(content)
    items << [:instruction, content]
  end
end

class ProducerNotes < Notes
  def chat(content)
    items << [:chat, content]
  end
end

class FacilitatorNotes < Notes
  def spoken(content)
    items << [:spoken, content]
  end
end

