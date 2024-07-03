require 'forwardable'

module BCF
  class FlightPlan
    attr_accessor :module_number,
                  :module_title,
                  :blocks,
                  :total_length,
                  :initial_time

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

      def block(block_instance = nil, lead_by: nil, &block_constructor)
        if block_instance and block_instance.is_a? Block
          @flight_plan.blocks << block_instance.with_speaker(lead_by)
        else
          @flight_plan.blocks << Block.new(&block_constructor).with_speaker(lead_by)
        end
      end

      def total_length(length)
        @flight_plan.total_length = length
      end

      def initial_time(time)
        @flight_plan.initial_time = time
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
                  :producer_notes,
                  :speaker,
                  :section_comment

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
        @block.facilitator_notes = FacilitatorNotes.new(&block)
      end

      def producer(&block)
        @block.producer_notes = ProducerNotes.new(&block)
      end

      def resources(&block)
        puts "TODO: Implement resources"
      end

      def default_leader(speaker)
        @block.speaker = speaker
      end

      def lead_by(speaker)
        @block.speaker = speaker
      end

      def section_comment(comment)
        @block.section_comment = comment
      end
    end

    def initialize(&block)
      @facilitator_notes = nil
      @producer_notes = nil
      DSL.new(self, &block)
    end

    def with_speaker(speaker)
      return self.clone unless speaker
      self.clone.instance_eval do
        @speaker = speaker
        self
      end
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
  end
end
