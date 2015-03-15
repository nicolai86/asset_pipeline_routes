ENV["RAILS_ENV"] ||= 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

FIXTURE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))

require 'asset_pipeline_routes'
require 'rspec'
require 'ostruct'