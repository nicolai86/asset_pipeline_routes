# encoding: UTF-8
require_relative "asset_pipeline_routes/version"

module AssetPipelineRoutes
  autoload :Path, 'asset_pipeline_routes/path'
  autoload :Routes, 'asset_pipeline_routes/routes'
  autoload :JsFunctionHelper, 'asset_pipeline_routes/js_function_helper'
  autoload :RoutesContext, 'asset_pipeline_routes/routes_context'
end

require_relative "asset_pipeline_routes/railtie" if defined?(Rails)