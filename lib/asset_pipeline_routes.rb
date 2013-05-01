# encoding: UTF-8
require "asset_pipeline_routes/version"
require "asset_pipeline_routes/path"
require "asset_pipeline_routes/routes"
require "asset_pipeline_routes/js_function_helper"
require "asset_pipeline_routes/routes_context"

if defined?(Rails)
  require "asset_pipeline_routes/railtie"
end

module AssetPipelineRoutes
end