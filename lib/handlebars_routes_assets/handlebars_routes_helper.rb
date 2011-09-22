module HandlebarsRoutesAssets
  class RoutesHelper
    def initialize(routes)
      default_block = '{{\1}}'
      routes.each do |route|
        self.class.instance_eval do
          define_method :"#{route.name}_path" do |mapping = default_block |
            build_url route, mapping
          end
        end
      end
    end

    def build_url route, mapping
      route.path.gsub(/\(\.:\w+\)/,'').gsub(/:(\w+)/, mapping).to_s
    end
  end
end