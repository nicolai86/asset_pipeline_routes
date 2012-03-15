# encoding: UTF-8
module AssetPipelineRoutes
  class Path
    DEFAULT_REPLACEMENT = '{{\1}}'

    attr_accessor :route

    def self.proc_for_route route
      proc { |id_replacement = DEFAULT_REPLACEMENT, *args|
        proc { |route, replacement, *mapping|
          Path.new(route.path.ast.to_s).build replacement, *mapping
        }.curry[route].call(id_replacement, *args)
      }
    end

    def initialize route_str
      @route = route_str
    end

    def apply_format options = {}
      @route = @route.sub(/\(\.:\w+\)/,format(options))
    end

    def build *args
      apply_format args.extract_options!
      replacements(*args).inject(@route) { |route, param|
        route.sub(/:(\w+)/, param.to_s)
      }
    end

    def format options
      str = options.fetch(:format) { '' }
      str = ".#{str}" unless str.empty? && str[0] != '.'
      str
    end

    def default_replacements
      Array.new(number_of_replacements, DEFAULT_REPLACEMENT)
    end

    def replacements *args
      defaults = default_replacements
      defaults[0...args.length] = args
      defaults
    end

    def number_of_replacements
      @route.scan(/:(\w+)/).inject(0) { |sum, n| sum + 1 }
    end
  end
end