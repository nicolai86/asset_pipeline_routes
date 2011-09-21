module Sprockets
  class Context

    def r
      @r ||= HandlebarsRoutesAssets::RoutesHelper.new(Rails.application.routes.routes)
    end

  end
end