module BCF
  class FlightPlan
    def self.from_json(json_str)
      json = JSON.parse(json_str)
      flight_plan = new

      flight_plan.module_number = json['module_number']
      flight_plan.module_title = json['module_title']
      flight_plan.total_length = json['total_length']
      flight_plan.initial_time = json['initial_time']
      flight_plan.learning_outcomes = json['learning_outcomes']
      flight_plan.demo = json['demo']
      flight_plan.blocks = json['blocks']&.map do |block_json|

      end
    end

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
        section_comment: self.section_comment, # markdown / typst
        facilitator_notes: self.facilitator_notes, # markdown / typst
        producer_notes: self.producer_notes, # markdown / typst
        resources: self.resources # resources associated with the block
      }.to_json(*args)
    end
  end
end
