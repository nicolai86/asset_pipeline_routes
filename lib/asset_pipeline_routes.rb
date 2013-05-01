# encoding: UTF-8
require "asset_pipeline_routes/version"
require "asset_pipeline_routes/path"
require "asset_pipeline_routes/routes"
require "asset_pipeline_routes/path_processor"

if defined?(Rails)
  require "asset_pipeline_routes/railtie"
end

module AssetPipelineRoutes
end