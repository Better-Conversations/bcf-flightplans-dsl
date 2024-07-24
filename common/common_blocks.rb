require_relative '../bcf'

module BCF
  module CommonBlocks
    PRE_FLIGHT = Block.build do
      length 25
      name "Pre-Flight checklist"

      producer do
        instruction "Sponsor and producer run through the pre-flight checklist (above)"
      end
    end

    SPONSOR_CLOSE = Block.build do
      length 16
      name "Sponsor Close"
      default_leader :sponsor

      facilitator do
        instruction "Thank the facilitators and producer"
        instruction "Mention to attendees that they are here to learn to deliver the course, as well as experience it as an attendee"
        instruction "Let attendees know that the session is finished and thank them."
        instruction "Say they are welcome to stay for 15 minutes or so if they have any questions for the team or any insights they’d like to share. After that the delivery team will debrief."
        instruction "Sponsor to facilitate discussion with attendees"
      end
    end

    SPONSOR_DEBRIEF = Block.build do
      length 15
      name "Debrief"
      default_leader :sponsor

      facilitator do
        instruction "Sponsor to facilitate debrief with delivery team on how session has gone and note any further observations, learnings etc."
      end
    end

    class Fieldwork < Block
      # @param [Array<String>] points Points to be covered in the fieldwork
      def initialize(points, id:, description:, length:)
        super()
        points_body = points.map { |point| "- #{point}" }.join("\n")

        BCF::Block::DSL.new(self) do
          name "Fieldwork"
          length length

          resources do
            fieldwork(id, description)
          end

          facilitator do
            spoken "We will send out the fieldwork by email. The suggested fieldwork for this module is to..."
            spoken(points_body, fixed: true)
          end

          producer do
            chat "Fieldwork:\n #{points_body}"
          end
        end
      end
    end
  end
end