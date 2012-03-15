# encoding: UTF-8
require 'active_support/core_ext/string/inflections'

module AssetPipelineRoutes
  module JsFunctionHelper
    extend self

    def route_to_anonymous_function route, style = :js
      function_arguments = route.scan(/:(\w+)/).flatten.map { |param|
        param.camelcase(:lower)
      }
      url_parts = route.split(/:\w+/).map{ |fragment| "'#{fragment}'" }
      function = if style == :js
        <<-JS
          (function() {
            return function (#{function_arguments.join ', '}) {
              return #{url_parts.zip(function_arguments).flatten.reject{ |part| part.nil? }.join(' + ')}
            };
          }).call(this);
        JS
      elsif style == :coffee
        <<-COFFEESCRIPT
          (-> (#{function_arguments.join ', '}) -> #{url_parts.zip(function_arguments).flatten.reject{ |part| part.nil? }.join(' + ')})(this)
        COFFEESCRIPT
      end
      function.gsub(/\s+/,' ').strip
    end
  end
end