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

      def as_json
        {
          JSON.create_id => json_class_name,
          :metadata => metadata
        }.merge(json_fields.to_h)
      end

      def to_json(*args)
        as_json.to_json(*args)
      end
    end

    # A mixin to add JSON deserialization to objects with default constructors and all state in instance variables
    module SimpleJSONDeserialization
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def new_for_json
          new
        end

        def json_create(object)
          obj = new_for_json

          object.each do |key, value|
            next if key == JSON.create_id
            obj.instance_variable_set(:"@#{key}", value)
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

      def self.new_for_json
        obj = new
        # Reset the version as we want to use the version from the JSON object
        obj.version = nil
        obj
      end
    end

    class Block
      include SimpleJSONSerialization
      include SimpleJSONDeserialization

      def json_class_name
        "BCF::FlightPlans::Block"
      end
    end

    class Notes
      include SimpleJSONSerialization
      include SimpleJSONDeserialization

      def json_fields
        super.reject do |k, v|
          k == :containing_block
        end
      end
    end
  end
end
