# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "asset_pipeline_routes/version"

Gem::Specification.new do |s|
  s.name        = "asset_pipeline_routes"
  s.version     = AssetPipelineRoutes::VERSION
  s.authors     = ["Raphael Randschau"]
  s.email       = ["nicolai86@me.com"]
  s.homepage    = ""
  s.summary     = %q{Add a routes helper for all asset pipeline needs}
  s.description = %q{Add a routes helper for all asset pipeline needs}

  s.rubyforge_project = "asset_pipeline_routes"

  s.files         = Dir.glob("{lib,spec}/**/*") + %w(README.md Rakefile)
  s.require_paths = ["lib"]

  s.add_development_dependency 'rails', '~> 3.2.0'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ci_reporter'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
end