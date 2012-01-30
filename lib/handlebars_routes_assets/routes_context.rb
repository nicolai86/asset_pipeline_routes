module HandlebarsRoutesAssets
  class RoutesContext

    def r
      @r ||= HandlebarsRoutesAssets::RoutesHelper.new(Rails.application.routes.routes)
    end

  end
end