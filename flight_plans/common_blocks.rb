require_relative '../bcf'

module BCF
  module CommonBlocks
    PRE_FLIGHT = Block.new do
      length 25
      name "Pre-Flight checklist"

      producer do
        instruction "Sponsor and producer run through the pre-flight checklist (above)"
      end
    end
  end
end