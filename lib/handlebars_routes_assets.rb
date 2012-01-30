require "handlebars_routes_assets/version"
require "handlebars_routes_assets/handlebars_routes_helper"
require "handlebars_routes_assets/sprockets_context"
require "handlebars_routes_assets/routes_helper"
require "handlebars_routes_assets/routes_context"

module HandlebarsRoutesAssets
  class Railtie < ::Rails::Railtie
    initializer "handlebars_routes_assets.environment" do |app|
     	ActiveSupport.on_load(:action_view) do
     	  include ::HandlebarsRoutesAssets::RoutesContext
     	  app.assets.context_class.instance_eval do
     	    include ::HandlebarsRoutesAssets::RoutesContext
        end
     	end
    end
  end
end
