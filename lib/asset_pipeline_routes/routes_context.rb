# encoding: UTF-8
module AssetPipelineRoutes
  module RoutesContext
    def r
      @r ||= ::AssetPipelineRoutes::Routes.new(Rails.application.routes.routes)
    end
  end
end