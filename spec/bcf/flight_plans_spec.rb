# frozen_string_literal: true

RSpec.describe BCF::FlightPlans do
  it "has a version number" do
    expect(BCF::FlightPlans::VERSION).not_to be nil
  end

  describe "page sizing" do
    let(:json) { Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read }

    it "renders the page as A4 by default" do
      flight_plan = JSON.parse(json, {create_additions: true})

      tf = Tempfile.new(["flightplan", ".pdf"])
      flight_plan.render_pdf(tf.path)

      pdf = PDF::Reader.new(tf.path)

      pdf.pages.each do |page|
        # Get the page size
        page_size = page.attributes[:MediaBox]

        # The MediaBox is typically in the format [llx lly urx ury]
        # where llx and lly are the coordinates of the lower-left corner,
        # and urx and ury are the coordinates of the upper-right corner.

        width = page_size[2] - page_size[0]
        height = page_size[3] - page_size[1]

        expect(height).to be_within(0.1).of(595.28)
        expect(width).to be_within(0.1).of(841.89)
      end
    end

    it "renders US Letter when specified" do
      flight_plan = JSON.parse(json, {create_additions: true})

      tf = Tempfile.new(["flightplan", ".pdf"])
      flight_plan.render_pdf(tf.path, page_size: "us-letter")

      pdf = PDF::Reader.new(tf.path)

      pdf.pages.each do |page|
        # Get the page size
        page_size = page.attributes[:MediaBox]

        # The MediaBox is typically in the format [llx lly urx ury]
        # where llx and lly are the coordinates of the lower-left corner,
        # and urx and ury are the coordinates of the upper-right corner.

        width = page_size[2] - page_size[0]
        height = page_size[3] - page_size[1]

        expect(height).to be_within(0.1).of(612)
        expect(width).to be_within(0.1).of(792)
      end
    end
  end

  describe "loading the example flight plan" do
    let(:json) { Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read }

    it "render a flightplan" do
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

  describe "abbreviated style" do
    let(:json) { Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read }

    it "renders a flight plan with abbreviated style and includes BY-SA 4.0" do
      flight_plan = JSON.parse(json, {create_additions: true})
      tf = Tempfile.new(["abbreviated_flightplan", ".pdf"])
      expect(flight_plan).to be_a(BCF::FlightPlans::FlightPlan)

      expect {
        flight_plan.render_pdf(tf.path, style: "abbreviated")
      }.not_to raise_error

      expect(File.exist?(tf.path)).to be_truthy
      expect(File.size(tf.path)).to be > 0 if File.exist?(tf.path)

      # Check each page contains the specific copyright text
      reader = PDF::Reader.new(tf.path)

      reader.pages.each do |page|
        expect(page.text).to include("BY-SA 4.0")
      end

      # Check the first page is not the full copyright page
      expect(reader.pages.first.text).not_to include("Your rights and obligations")
    end
  end

  describe "migrations" do
    describe "from un-versioned" do
      let(:json) { Pathname.new(__FILE__).join("..", "..", "fixtures", "module_3.json").read }

      it "defaults to version 0.4.4 after migration as it has no version specified" do
        flight_plan = JSON.parse(json, {create_additions: true})
        expect(flight_plan.version).to be_nil

        flight_plan.migrate!

        expect(flight_plan.version).to eq("0.4.4")
      end

      it "adds an index to each block" do
        flight_plan = JSON.parse(json, {create_additions: true})
        flight_plan.migrate!

        flight_plan.blocks.each do |block|
          expect(block.index).to be_a(Integer)
        end
      end

      it "migrates the notes to have a unique id" do
        flight_plan = JSON.parse(json, {create_additions: true})
        flight_plan.migrate!

        ids = flight_plan.blocks.flat_map do |block|
          a = block.facilitator_notes&.items&.each { _1.id } || []
          b = block.producer_notes&.items&.each { _1.id } || []

          a + b
        end

        expect(ids.uniq.length).to eq(ids.length)
      end

      it "has consistent ids across reloads" do
        flight_plan_1 = JSON.parse(json, {create_additions: true})
        flight_plan_2 = JSON.parse(json, {create_additions: true})
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

  describe "json ser/de" do
    it "is round-trippable" do
      json_text = Pathname.new(__FILE__).join("..", "..", "fixtures", "m1.json").read
      fp = JSON.parse(json_text, { create_additions: true})
      expect(fp).to be_a(BCF::FlightPlans::FlightPlan)
      expect(fp.validate).to be_truthy
      expect(fp.to_json).to eq(json_text)
    end
  end
end
