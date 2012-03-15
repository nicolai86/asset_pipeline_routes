# encoding: UTF-8
require_relative "asset_pipeline_routes/version"
require_relative "asset_pipeline_routes/routes"

module AssetPipelineRoutes
  class Railtie < ::Rails::Railtie
    initializer "asset_pipeline_routes.environment" do |app|
      ActiveSupport.on_load(:action_view) do
        include ::AssetPipelineRoutes::RoutesContext

        app.assets.context_class.instance_eval do
          include ::AssetPipelineRoutes::RoutesContext
        end
      end
    end
  end
end
