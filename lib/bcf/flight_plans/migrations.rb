module BCF
  module FlightPlans
    class FlightPlan
      def migrate!
        # Pre 0.5 we didn't include a version so we default to this version
        if version.nil?
          self.version = "0.4.4"
        end

        if version == "0.4.4"
          blocks.each_with_index do |block, index|
            block.index = index

            block.facilitator_notes&.items = block.facilitator_notes&.items&.map&.with_index do |note, note_index|
              note.new(id: "block-#{index}-facilitator-note-#{note_index}")
            end

            block.producer_notes&.items = block.producer_notes&.items&.map&.with_index do |note, note_index|
              note.new(id: "block-#{index}-producer-note-#{note_index}")
            end
          end
        end
      end
    end
  end
end
