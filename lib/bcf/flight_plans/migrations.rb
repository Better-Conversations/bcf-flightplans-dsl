module BCF
  module FlightPlans
    class FlightPlan
      def migrate!
        # Pre 0.5 we didn't include a version so we default to this version
        if self.version.nil?
          self.version = "0.4.4"
        end

        if self.version == "0.4.4"
          self.blocks.each_with_index do |block, index|
            block.index = index

            block.facilitator_notes&.items&.each_with_index do |note, note_index|
              note.id = "block-#{index}-facilitator-note-#{note_index}"
            end

            block.producer_notes&.items&.each_with_index do |resource, resource_index|
              resource.id = "block-#{index}-producer-note-#{resource_index}"
            end
          end
        end
      end
    end
  end
end
