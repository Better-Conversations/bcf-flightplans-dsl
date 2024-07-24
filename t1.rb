require_relative './bcf'

i = BCF::Instruction.new("Hello, world!")
puts i
puts i.to_json
puts JSON.parse(i.to_json, create_additions: true)
BCF::Instruction.json_creatable?
