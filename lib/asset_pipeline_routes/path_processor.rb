# encoding: UTF-8
require 'sprockets/processor'

module AssetPipelineRoutes
  class PathProcessor < ::Sprockets::Processor
    def r
      @r ||= Routes.new(Rails.application.routes.routes)
    end
    def r= new_r
      @r = new_r
    end

    def evaluate context, locals
      data.gsub /[^\w]r\((.+)\)/ do |match|
        parts = $1.split(',').map(&:strip)
        route = parts.shift.to_sym

        if r.respond_to? route
          r.send route, *parts
        else
          "''"
        end
      end
    end
  end
end