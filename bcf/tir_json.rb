module BCF
  class FlightPlan
    def to_json(*args)
      {
        json_class: self.class.name, # string

        module_number: self.module_number, # int
        module_name: self.module_title, # string
        total_length: self.total_length, # int
        initial_time: self.initial_time, # int
        learning_outcomes: self.learning_outcomes, # markdown / typst
        demo: self.demo, # markdown / typst,
        blocks: self.blocks
      }.to_json(*args)
    end

    def self.json_create(object)
      new(*object['a'])
    end
  end

  class Block
    def to_json(*args)
      {
        json_class: self.class.name, # string

        name: self.name, # string
        length: self.length, # int
        speaker: self.speaker, # string
        section_info: self.section_info, # markdown / typst
        facilitator_notes: self.facilitator_notes, # markdown / typst
        producer_notes: self.producer_notes, # markdown / typst
        resources: self.resources # resources associated with the block
      }.to_json(*args)
    end
  end
end
