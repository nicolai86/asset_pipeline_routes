# encoding: UTF-8
module AssetPipelineRoutes
  class Railtie < ::Rails::Railtie
    initializer "asset_pipeline_routes.environment" do |app|
      ActiveSupport.on_load(:action_view) do
        app.assets.register_preprocessor('application/javascript', PathProcessor)
      end
    end
  end
end
