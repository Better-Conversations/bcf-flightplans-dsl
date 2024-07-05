require 'pathname'
require_relative '../bcf'

file = ARGV[0]
relative_path = Pathname.new(file).relative_path_from(Pathname.new(Dir.pwd)).to_s
name = File.basename(file, '.rb')

puts "Compiling #{relative_path}..."

# The path we are provided is absolute so we don't need to
require_relative File.expand_path(file, Pathname.new(__FILE__).parent.to_s)

# Generate PDF and JSON
flight_plan = BCF::FLIGHT_PLANS.first
if flight_plan.nil?
  puts "No flight plan found!"
  exit
end

flight_plan.render_pdf("output/#{name}.pdf")
flight_plan.write_json("output/#{name}.json")

puts "Done!"