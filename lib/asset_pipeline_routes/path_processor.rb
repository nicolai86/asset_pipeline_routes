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
      data.gsub /[^[[:word:]]]r\(([[:word:]]+),?(.*)\)/ do |match|
        parts = $2.split(',').map(&:strip).reject(&:blank?)
        route = $1.to_sym

        wrap = (match[0] == '(')

        expanded = if r.respond_to? route
          r.send route, *parts
        else
          "''"
        end

        wrap ? "(#{expanded})" : expanded
      end
    end
  end
end