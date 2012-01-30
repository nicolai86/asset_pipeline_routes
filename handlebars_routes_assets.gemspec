# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "asset_pipeline_routes/version"

Gem::Specification.new do |s|
  s.name        = "handlebars_routes_assets"
  s.version     = AssetPipelineRoutes::VERSION
  s.authors     = ["Raphael Randschau"]
  s.email       = ["nicolai86@me.com"]
  s.homepage    = ""
  s.summary     = %q{Add a routes helper for all asset pipeline needs}
  s.description = %q{Add a routes helper for all asset pipeline needs}

  s.rubyforge_project = "asset_pipeline_routes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rails', '~> 3.2.0'
  s.add_development_dependency 'rspec'
end