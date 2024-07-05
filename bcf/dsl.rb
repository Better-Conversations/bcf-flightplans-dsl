require 'forwardable'

module BCF
  FLIGHT_PLANS = []

  class FlightPlan
    attr_accessor :module_number,
                  :module_title,
                  :blocks,
                  :total_length,
                  :initial_time,
                  :learning_outcomes,
                  :demo,
                  :organisation

    def validate
      raise "Module number is required" unless module_number
      raise "Module title is required" unless module_title
      raise "Blocks are required" if blocks.empty?
      raise "Total length is required" unless total_length
      raise "Initial time is required" unless initial_time

      runtime = self.blocks.reduce(initial_time) do |time, block|
        time + block.length
      end

      warn "Total length (#{total_length}) does not match block lengths (#{runtime})" unless runtime == total_length

      puts "Found resources:"
      resources.each do |resource|
        puts "  #{resource}"
      end
    end

    def resources
      blocks.map(&:resources).flatten
    end

    def flipcharts
      resources.select { |r| r.is_a? BCF::Resource::Flipchart }
    end

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

      def block(block_instance = nil, **kwargs, &block_constructor)
        if block_instance and block_instance.is_a? Block
          @flight_plan.blocks << block_instance.with_additional(**kwargs)
        else
          @flight_plan.blocks << Block.new(&block_constructor).with_additional(**kwargs)
        end
      end

      def total_length(length)
        @flight_plan.total_length = length
      end

      def initial_time(time)
        @flight_plan.initial_time = time
      end

      def learning_outcomes(content)
        @flight_plan.learning_outcomes = content
      end

      def demo(content)
        @flight_plan.demo = content
      end
    end

    def initialize(&block)
      @blocks = []
      DSL.new(self, &block)
      BCF::FLIGHT_PLANS << self
    end
  end

  class Block
    attr_accessor :name,
                  :length,
                  :facilitator_notes,
                  :producer_notes,
                  :speaker,
                  :section_comment,
                  :resources

    class DSL
      class ResourcesDSL
        attr_accessor :resources

        def initialize(&block)
          @resources = []
          instance_eval &block
        end

        def flipchart(id, inplace_comment, description: nil, scribed_by: nil)
          resources << Resource::Flipchart.new(id:, description:, inplace_comment:, scribed_by:)
        end

        def breakout_room(id)
          resources << Resource::Breakout.new(id)
        end

        def fieldwork(id, description)
          resources << Resource::Fieldwork.new(id, description)
        end
      end

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
        @block.facilitator_notes = FacilitatorNotes.new(&block)
      end

      def producer(&block)
        @block.producer_notes = ProducerNotes.new(&block)
      end

      def resources(&block)
        @block.resources.append(*ResourcesDSL.new(&block).resources)
      end

      def lead_by(speaker)
        @block.speaker = speaker
      end

      alias_method :default_leader, :lead_by

      def section_comment(comment)
        @block.section_comment = comment
      end
    end

    def initialize(&block)
      @facilitator_notes = nil
      @producer_notes = nil
      @resources = []
      DSL.new(self, &block)
    end

    # FIXME: This is a little hacky
    def with_additional(**kwargs)
      new_block = self.clone
      dsl = DSL.new(new_block, &Proc.new {})

      kwargs.each do |k, v|
        dsl.send(k, v)
      end

      new_block
    end
  end

  class Note; end

  class Instruction < Note
    attr_accessor :content

    def initialize(content)
      @content = content
    end
  end

  class Chat < Note
    attr_accessor :content

    def initialize(content)
      @content = content
    end
  end

  class Spoken < Note
    attr_accessor :content, :fixed

    def initialize(content, fixed: false)
      @content = content
      @fixed = fixed
    end
  end

  class Notes
    attr_accessor :items

    def initialize(&block)
      @items = []
      instance_eval &block
    end

    def instruction(content)
      items << Instruction.new(content)
    end
  end

  class ProducerNotes < Notes
    def chat(content)
      items << Chat.new(content)
    end
  end

  class FacilitatorNotes < Notes
    def spoken(content, fixed: false)
      items << Spoken.new(content, fixed:)
    end

    def spoken_fixed(content)
      spoken(content, fixed: true)
    end
  end

  module Resource
    Flipchart = Struct.new(:id, :inplace_comment, :description, :scribed_by) do
      def inplace_section_comment
        "#{id} #{inplace_comment}"
      end

      def pretty_id
        self.id.to_s.capitalize.gsub(/_/, '#')
      end

      def pretty_scribed_by
        self.scribed_by.to_s.capitalize
      end
    end

    Breakout = Struct.new(:id)
    Fieldwork = Struct.new(:id, :description)
  end
end
