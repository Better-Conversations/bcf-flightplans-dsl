module BCF
  module FlightPlans
    class FlightPlan
      class DSL
        attr_reader :flight_plan

        def initialize(flight_plan, &block)
          @flight_plan = flight_plan
          instance_eval(&block)
        end

        def module_number(number)
          @flight_plan.module_number = number
        end

        def module_title(title)
          @flight_plan.module_title = title
        end

        def block(block_instance = nil, **kwargs, &block_constructor)
          @flight_plan.blocks << if block_instance.is_a? Block
            block_instance.with_additional(**kwargs, index: @flight_plan.blocks.length)
          else
            Block.build(&block_constructor).with_additional(**kwargs, index: @flight_plan.blocks.length)
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

      def self.build(&block)
        dsl = DSL.new(new, &block)
        BCF::FlightPlans::FLIGHT_PLANS << dsl.flight_plan
        dsl.flight_plan
      end
    end

    class Block
      class DSL
        attr_reader :block

        class ResourcesDSL
          attr_accessor :resources

          def initialize(&block)
            @resources = []
            instance_eval(&block)
          end

          def flipchart(id, inplace_comment, description: nil, scribed_by: nil)
            resources << Resource::Flipchart.new(id:, description:, inplace_comment:, scribed_by:)
          end

          def breakout_room(id, default_duration:, notify_halfway: true)
            resources << Resource::Breakout.new(id, default_duration:, notify_halfway:)
          end

          def fieldwork(id, description)
            resources << Resource::Fieldwork.new(id, description)
          end
        end

        def initialize(obj, &block)
          @block = obj
          instance_eval(&block)
        end

        def name(name)
          @block.name = name
        end

        def length(length)
          @block.length = length
        end

        def facilitator(&block)
          @block.facilitator_notes = FacilitatorNotes.build(&block)
        end

        def producer(&block)
          @block.producer_notes = ProducerNotes.build(&block)
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

      def self.build(&block)
        DSL.new(new, &block).block
      end
    end

    class ProducerNotes
      def chat(content)
        items << Chat.new(content)
      end

      def broadcast(content)
        items << Chat.new(content, broadcast: true)
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
  end
end
