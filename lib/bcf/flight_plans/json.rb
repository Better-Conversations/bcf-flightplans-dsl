module BCF
  module FlightPlans
    module SimpleJSONSerialization
      # Use to allow helper classes to deserialize into the base class
      def json_class_name
        self.class.name
      end

      def metadata
        nil
      end

      def json_fields
        instance_variables.map { |var| [var[1..].to_sym, instance_variable_get(var)] }
      end

      def to_json(*args)
        {
          JSON.create_id => self.json_class_name,
          metadata: self.metadata
        }.merge(json_fields.to_h).to_json(*args)
      end
    end

    # A mixin to add JSON deserialization to objects with default constructors and all state in instance variables
    module SimpleJSONDeserialization
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def json_create(object)
          obj = new

          object.each do |key, value|
            next if key == JSON.create_id
            obj.instance_variable_set("@#{key}", value)
          end

          obj
        end
      end
    end

    class FlightPlan
      include SimpleJSONSerialization
      include SimpleJSONDeserialization

      def json_class_name
        "BCF::FlightPlans::FlightPlan"
      end
    end

    class Block
      include SimpleJSONSerialization
      include SimpleJSONDeserialization

      def json_class_name
        "BCF::FlightPlans::Block"
      end
    end

    class Note
      include SimpleJSONSerialization
      include SimpleJSONDeserialization
    end

    class Instruction < Note
      def self.json_create(object)
        new(object["content"])
      end
    end

    class Chat < Note
      def self.json_create(object)
        new(object["content"])
      end
    end

    class Spoken < Note
      def self.json_create(object)
        new(object["content"], fixed: object["fixed"])
      end
    end

    class Notes
      include SimpleJSONSerialization
      include SimpleJSONDeserialization
    end
  end
end
