# frozen_string_literal: true

require "json"
require "json/add/struct"
require "tilt"
require "tilt/erb"
require "redcarpet"
require "tmpdir"
require "tempfile"
require "date"
require "open3"
require "securerandom"

require_relative "flight_plans/version"
require_relative "flight_plans/models"
require_relative "flight_plans/json"
require_relative "flight_plans/renderer"
require_relative "flight_plans/dsl"
require_relative "flight_plans/migrations"

module BCF
  module FlightPlans
    class Error < StandardError; end

    class TypstMissingError < Error
      def initialize
        super("Typst is required to render flight plans to PDF. See https://github.com/typst/typst for instructions.")
      end
    end

    class TypstCompileError < Error
      attr_accessor :stdout
      attr_accessor :stderr
      attr_accessor :exit_code
      attr_accessor :typst_source

      def initialize(stdout, stderr, exit_code, typst_source)
        super("Typst compile failed with stderr: #{stderr}")

        @stdout = stdout
        @stderr = stderr
        @exit_code = exit_code
        @typst_source = typst_source
      end
    end

    class ValidationError < Error
      attr_accessor :flight_plan
      attr_accessor :errors

      def initialize(flight_plan, errors)
        super("Flightplan #{flight_plan.module_number} #{flight_plan.module_title} failed validation. Errors: #{errors}")

        @flight_plan = flight_plan
        @errors = errors
      end
    end
  end
end
