# encoding: UTF-8
require "active_support/core_ext/array/extract_options"
require 'active_support/core_ext/string/inflections'

module AssetPipelineRoutes
  class Routes
    def initialize routes
      define_application_routes routes
    end

    def define_application_routes routes
      routes.select{ |route| named_route?(route) }.each do |route|
        define_route route
      end
    end

    def define_route route
      self.class.instance_eval do
        define_method :"#{route.name}_path", Path.proc_for_route(route)
      end
    end

    def named_route? route
      !route.name.nil?
    end
  end
end
