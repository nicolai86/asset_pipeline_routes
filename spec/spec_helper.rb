ENV["RAILS_ENV"] = "test"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'handlebars_routes_assets/handlebars_routes_helper'
require 'rspec'
require 'ostruct'