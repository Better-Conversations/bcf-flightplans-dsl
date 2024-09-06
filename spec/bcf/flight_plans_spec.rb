# frozen_string_literal: true

RSpec.describe BCF::FlightPlans do
  it "has a version number" do
    expect(BCF::FlightPlans::VERSION).not_to be nil
  end

  it "render a flightplan" do
    json = Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read
    flight_plan = JSON.parse(json, {create_additions: true})

    tf = Tempfile.new(["flightplan", ".pdf"])
    expect(flight_plan).to be_a(BCF::FlightPlans::FlightPlan)
    expect(flight_plan.validate).to be_truthy

    expect {
      flight_plan.render_pdf(tf.path)
    }.not_to raise_error

    expect(File.exist?(tf.path)).to be_truthy
    expect(File.size(tf.path)).to be > 0 if File.exist?(tf.path)
  end
end
