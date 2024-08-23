module BCF
  module FlightPlans
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

      def initialize
        @blocks = []
      end

      def validate
        warn "Module number is required" unless module_number
        warn "Module title is required" unless module_title
        warn "Blocks are required" if blocks.empty?
        warn "Total length is required" unless total_length
        warn "Initial time is required" unless initial_time

        blocks.each.with_index do |block, index|
          warn "Block number #{index + 1} of Module #{module_number} #{module_title} is missing a name." unless block.name
          warn "Block \"#{block.name}\" is missing a length" unless block.length
        end

        runtime = blocks.reduce(initial_time) do |time, block|
          time + block.length
        end

        warn "Total length (#{total_length}) does not match block lengths (#{runtime})" unless runtime == total_length
      end

      def resources
        blocks.map(&:resources).flatten
      end

      def flipcharts
        resources.select { |r| r.is_a? BCF::FlightPlans::Resource::Flipchart }
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

      def initialize
        @resources = []
      end

      # FIXME: This is a little hacky
      def with_additional(**kwargs)
        new_block = clone
        dsl = DSL.new(new_block, &proc {})

        kwargs.each do |k, v|
          dsl.send(k, v)
        end

        new_block
      end

      def flipchart
        resources.find { |r| r.is_a? BCF::FlightPlans::Resource::Flipchart }
      end
    end

    class Note; end

    class Instruction < Note
      attr_accessor :content

      def initialize(content)
        super()
        @content = content
      end
    end

    class Chat < Note
      attr_accessor :content

      def initialize(content)
        super()
        @content = content
      end
    end

    class Spoken < Note
      attr_accessor :content, :fixed

      def initialize(content, fixed: false)
        super()
        @content = content
        @fixed = fixed
      end
    end

    class Notes
      attr_accessor :items

      def self.build(&block)
        obj = new
        obj.instance_eval(&block)
        obj
      end

      def initialize
        @items = []
      end

      def instruction(content)
        items << Instruction.new(content)
      end
    end

    class ProducerNotes < Notes
      # TODO: Should this be in the DSL?
      def chat(content)
        items << Chat.new(content)
      end
    end

    class FacilitatorNotes < Notes
      def spoken(content, fixed: false)
        items << Spoken.new(content, fixed: fixed)
      end

      def spoken_exact(content)
        items << Spoken.new(content, fixed: true)
      end

      alias_method :spoken_fixed, :spoken_exact
    end

    module Resource
      Flipchart = Struct.new(:id, :inplace_comment, :description, :scribed_by) do
        def inplace_section_comment
          "#{id} #{inplace_comment}"
        end

        def pretty_id
          id.to_s.capitalize.tr("_", "#")
        end

        def pretty_scribed_by
          scribed_by.to_s.capitalize
        end
      end

      Breakout = Struct.new(:id)
      Fieldwork = Struct.new(:id, :description)
    end
  end
end
