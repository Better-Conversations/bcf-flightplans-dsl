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
        :organisation,
        :version

      def initialize
        @blocks = []
        @version = BCF::FlightPlans::VERSION
      end

      def resources
        blocks.map(&:resources).flatten
      end

      def flipcharts
        resources.select { |r| r.is_a? BCF::FlightPlans::Resource::Flipchart }
      end

      def children
        blocks
      end
    end

    class Block
      attr_accessor :index,
        :name,
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

      def children
        [facilitator_notes, producer_notes, *resources].compact
      end
    end

    class BCFStruct < Dry::Struct
      transform_keys(&:to_sym)

      def self.json_create(object)
        new(object)
      end

      def json_class_name
        self.class.name
      end

      # This is a lift from to_h and Hashify in dry-struct which adds a JSON.create_id key to the hash.
      def as_json
        handle_item = lambda do |value|
          if value.is_a?(BCFStruct)
            value.as_json
          elsif value.is_a?(Dry::Struct)
            value.to_h.transform_values { |current| handle_item.call(current) }
          elsif value.respond_to?(:to_hash)
            value.to_hash.transform_values { |current| handle_item.call(current) }
          elsif value.respond_to?(:to_ary)
            value.to_ary.map { |item| handle_item.call(item) }
          else
            value
          end
        end

        base = self.class.schema.each_with_object({}) do |key, result|
          next unless attributes.key?(key.name)
          result[key.name] = handle_item.call(self[key.name])
        end

        base.merge(
          JSON.create_id => json_class_name
        )
      end

      def to_json(...)
        as_json.to_json(...)
      end
    end

    class Note < BCFStruct
      attribute :id, BCF::FlightPlans::Types::String.default { SecureRandom.uuid }
    end

    class Instruction < Note
      attribute :content, BCF::FlightPlans::Types::String
    end

    class Chat < Note
      attribute :content, BCF::FlightPlans::Types::String
      attribute :broadcast, BCF::FlightPlans::Types::Bool.default { false }
    end

    class Spoken < Note
      attribute :content, BCF::FlightPlans::Types::String
      attribute :fixed, BCF::FlightPlans::Types::Bool.default { false }
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
        items << Instruction.new(content:)
      end

      def children
        items
      end
    end

    class ProducerNotes < Notes
    end

    class FacilitatorNotes < Notes
    end

    module Resource
      Flipchart = Struct.new(:id, :inplace_comment, :description, :scribed_by) do
        def inplace_section_comment
          "#{pretty_id} #{inplace_comment}"
        end

        def pretty_id
          id.to_s.capitalize.tr("_", "#")
        end

        def pretty_scribed_by
          return nil if scribed_by.nil?
          scribed_by.to_s.capitalize
        end
      end

      Breakout = Struct.new(:id, :default_duration, :notify_halfway)
      Fieldwork = Struct.new(:id, :description)
    end
  end
end
