module HandlebarsRoutesAssets
  class RoutesHelper
    def initialize(routes)
      routes.each do |route|
        self.class.instance_eval do
          define_method :"#{route.name}_path" do
            build_url route
          end
        end
      end
    end

    def build_url route
      route.path.gsub(/\(\.:\w+\)/,'').gsub(/:(\w+)/) { "{{#{$1}}}" }.to_s
    end
  end
end