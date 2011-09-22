module HandlebarsRoutesAssets
  class RoutesHelper
    def initialize(routes)
      routes.each do |route|
        self.class.instance_eval do
          define_method :"#{route.name}_path" do |mapping = "{{#{$1}}}"|
            build_url route, mapping
          end
        end
      end
    end

    def build_url route, mapping = "{{#{$1}}}"
      route.path.gsub(/\(\.:\w+\)/,'').gsub(/:(\w+)/) { mapping }.to_s
    end
  end
end