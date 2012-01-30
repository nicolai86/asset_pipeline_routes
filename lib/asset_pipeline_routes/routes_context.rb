module AssetPipelineRoutes
  module RoutesContext

    def r
      @r ||= ::AssetPipelineRoutes::RoutesHelper.new(Rails.application.routes.routes)
    end

  end
end