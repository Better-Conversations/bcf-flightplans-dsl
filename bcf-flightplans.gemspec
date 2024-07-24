# frozen_string_literal: true

require_relative "lib/bcf/flightplans/version"

Gem::Specification.new do |spec|
  spec.name = "bcf-flightplans"
  spec.version = Bcf::Flightplans::VERSION
  spec.authors = ["Joshua Coles"]
  spec.email = ["josh@coles.to"]

  spec.summary = "Structure and generation of flightplans for BCF"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tilt", "~> 2.4"
  spec.add_dependency "redcarpet", "~> 3.6"
end
