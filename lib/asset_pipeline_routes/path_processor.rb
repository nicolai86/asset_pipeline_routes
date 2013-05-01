# encoding: UTF-8
module AssetPipelineRoutes
  class PathProcessor < Sprockets::Processor
    def evaluate context, locals
      data.gsub %{foo}, 42
    end
  end
end