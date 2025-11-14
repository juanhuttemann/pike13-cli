# frozen_string_literal: true

require_relative "lib/pike13/cli/version"

Gem::Specification.new do |spec|
  spec.name = "pike13-cli"
  spec.version = Pike13::CLI::VERSION
  spec.authors = ["Pike13 CLI Contributors"]
  spec.email = ["juanfhuttemann@gmail.com"]

  spec.summary = "Command-line interface for Pike13 API"
  spec.description = "A powerful CLI tool for interacting with Pike13's Core and Reporting APIs"
  spec.homepage = "https://github.com/juanhuttemann/pike13-cli"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob(%w[
                          lib/**/*.rb
                          bin/*
                          completions/*
                          LICENSE.txt
                          README.md
                          CHANGELOG.md
                          CONTRIBUTING.md
                        ])
  spec.bindir = "bin"
  spec.executables = ["pike13"]
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize", "~> 1.1"
  spec.add_dependency "pike13", "~> 0.1"
  spec.add_dependency "table_print", "~> 1.5"
  spec.add_dependency "thor", "~> 1.3"
end
