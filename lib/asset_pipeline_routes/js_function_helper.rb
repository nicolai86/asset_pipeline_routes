require 'active_support/core_ext/string/inflections'

module AssetPipelineRoutes
  module JsFunctionHelper
    class << self
      def route_to_anonymous_function route
        function_arguments = route.scan(/:(\w+)/).flatten.map { |param| 
          param.camelcase(:lower) 
        }
        url_parts = route.split(/:\w+/).map{ |fragment| "'#{fragment}'" }
        function = <<-JS 
        (function() { 
          return function (#{function_arguments.join ', '}) { 
            return #{url_parts.zip(function_arguments).join(' + ')}
          }; 
        }).call(this);
        JS
        function.gsub(/\s+/,' ').strip
      end
    end
  end
end