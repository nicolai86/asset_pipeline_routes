module Sprockets
  class Context

    def r
      @r ||= RoutesHelper.new Rails.application.routes.routes
    end

  end
end