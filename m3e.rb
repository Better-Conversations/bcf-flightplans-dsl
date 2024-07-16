require_relative './bcf'
require_relative 'flight_plans/module_3'

# Generate PDF and JSON
flight_plan = BCF::FLIGHT_PLANS.first
if flight_plan.nil?
  puts "No flight plan found!"
  exit
end

name = "m3e"
flight_plan.render_pdf("output/#{name}.pdf")
flight_plan.write_json("output/#{name}.json")

puts "Done!"
