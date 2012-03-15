require "active_support/core_ext/array/extract_options"

require_relative "routes_context"
require_relative "js_function_helper"

module AssetPipelineRoutes
  class RoutesHelper
    DEFAULT_REPLACEMENT = '{{\1}}'

    def initialize(routes, default_block = DEFAULT_REPLACEMENT)
      routes.each do |route|
        next if route.name.nil? # only handle named_routes

        self.class.instance_eval do
          define_method :"#{route.name}_path" do |id_replacement = default_block, *args|
            proc { |route, replacement, *mapping|
              build_url route.path.ast.to_s, replacement, *mapping
            }.curry[route].call(id_replacement, *args)
          end

          define_method :"#{route.name}_path_method" do |style = :js|
            AssetPipelineRoutes::JsFunctionHelper::route_to_anonymous_function build_url(route.path.ast.to_s, ':\1'), style
          end
        end
      end
    end

    def build_url path, *args
      path_with_format = path.sub(/\(\.:\w+\)/,format(args.extract_options!))
      replacements(path_with_format, *args).inject(path_with_format) { |route, param|
        route.sub(/:(\w+)/, param.to_s)
      }
    end

    def format options = {}
      str = options.fetch(:format) { '' }
      str = ".#{str}" unless str.empty? && str[0] != '.'
      str
    end

    def default_replacements path
      Array.new(number_of_replacements_in(path), DEFAULT_REPLACEMENT)
    end

    def replacements path, *args
      defaults = default_replacements(path)
      defaults[0...args.length] = args
      defaults
    end

    def number_of_replacements_in path
      path.scan(/:(\w+)/).inject(0) { |sum, n| sum + 1 }
    end
  end
end