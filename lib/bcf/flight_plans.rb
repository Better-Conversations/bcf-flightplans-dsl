# frozen_string_literal: true

require_relative "flightplans/version"
require_relative "flightplans/models"
require_relative "flightplans/json"
require_relative "flightplans/renderer"
require_relative "flightplans/dsl"

module BCF
  module FlightPlans
    class Error < StandardError; end
  end
end
