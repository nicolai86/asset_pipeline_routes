# encoding: UTF-8
require 'sprockets/processor'
require 'active_support/core_ext/object/blank'
module AssetPipelineRoutes
  class PathProcessor < ::Sprockets::Processor
    def r
      @r ||= Routes.new(Rails.application.routes.routes)
    end
    def r= new_r
      @r = new_r
    end

    def evaluate context, locals
      re = %r{
        (?<=[^[[:word:]]])r(?<re>
          \(
            (?:
              (?> [^()]+ )
              |
              \g<re>
            )*
          \)
        )
      }x
      data.gsub re do |match|
        str = match[2..-2]
        parts = str.split(',').map(&:strip).reject(&:blank?)
        route = parts.shift.to_sym

        expanded = if r.respond_to? route
          r.send route, *parts
        else
          "''"
        end
      end
    end
  end
end