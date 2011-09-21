# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "handlebars_routes_assets/version"

Gem::Specification.new do |s|
  s.name        = "handlebars_routes_assets"
  s.version     = HandlebarsRoutesAssets::VERSION
  s.authors     = ["Raphael Randschau"]
  s.email       = ["nicolai86@me.com"]
  s.homepage    = ""
  s.summary     = %q{Add a routes helper for all your haml_assets needs}
  s.description = %q{Add a routes helper for all your haml_assets needs}

  s.rubyforge_project = "handlebars_routes_assets"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
