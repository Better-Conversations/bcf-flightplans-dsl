# frozen_string_literal: true

RSpec.describe BCF::FlightPlans do
  it "has a version number" do
    expect(BCF::FlightPlans::VERSION).not_to be nil
  end

  describe 'loading the example flight plan' do
    let(:json) { Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read }

    it "render a flightplan" do
      flight_plan = JSON.parse(json, { create_additions: true })

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

  describe 'migrations' do
    describe 'from un-versioned' do
      let(:json) { Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read }

      it 'defaults to version 0.4.4 after migration as it has no version specified' do
        flight_plan = JSON.parse(json, { create_additions: true })
        expect(flight_plan.version).to be_nil

        flight_plan.migrate!

        expect(flight_plan.version).to eq("0.4.4")
      end

      it 'adds an index to each block' do
        flight_plan = JSON.parse(json, { create_additions: true })
        flight_plan.migrate!

        flight_plan.blocks.each do |block|
          expect(block.index).to be_a(Integer)
        end
      end

      it 'migrates the notes to have a unique id' do
        flight_plan = JSON.parse(json, { create_additions: true })
        flight_plan.migrate!

        ids = flight_plan.blocks.flat_map do |block|
          a = block.facilitator_notes&.items&.each { _1.id } || []
          b = block.producer_notes&.items&.each { _1.id } || []

          a + b
        end

        expect(ids.uniq.length).to eq(ids.length)
      end

      it 'has consistent ids across reloads' do
        flight_plan_1 = JSON.parse(json, { create_additions: true })
        flight_plan_2 = JSON.parse(json, { create_additions: true })
        flight_plan_1.migrate!
        flight_plan_2.migrate!

        ids_1 = flight_plan_1.blocks.flat_map do |block|
          a = block.facilitator_notes&.items&.each { _1.id } || []
          b = block.producer_notes&.items&.each { _1.id } || []

          a + b
        end

        ids_2 = flight_plan_1.blocks.flat_map do |block|
          a = block.facilitator_notes&.items&.each { _1.id } || []
          b = block.producer_notes&.items&.each { _1.id } || []

          a + b
        end

        expect(ids_1).to eq(ids_2)
      end
    end

  end
end
