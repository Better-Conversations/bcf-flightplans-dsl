# frozen_string_literal: true
require "json"
require "tilt"
require 'tilt/erb'
require "redcarpet"
require 'tmpdir'

require_relative "flight_plans/version"
require_relative "flight_plans/models"
require_relative "flight_plans/json"
require_relative "flight_plans/renderer"
require_relative "flight_plans/dsl"

module BCF
  module FlightPlans
    class Error < StandardError; end
  end
end
