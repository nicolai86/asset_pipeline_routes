require 'spec_helper'
require 'sprockets'

def build_route name, path
  OpenStruct.new({:name => name, :path => OpenStruct.new(:ast => path)})
end

module Rails
  def self.application
    return OpenStruct.new({
      routes: OpenStruct.new({
        routes: [
        build_route('users', '/users(.:format)'),
        build_route('user', '/users/:id(.:format)'),
        build_route('project_ticket', '/projects/:project_id/tickets/:id(.:format)')]
      })
    })
  end
end

describe AssetPipelineRoutes::PathProcessor do
  before do
    @env = Sprockets::Environment.new(".")
    @env.append_path(FIXTURE_ROOT)
    @env.register_preprocessor('application/javascript', ::AssetPipelineRoutes::PathProcessor)
  end

  it "replaces calls to r() with route" do
    @env['simple_route.js'].to_s.should == "var Bar ='/users';\n"
  end

  it "replaces calls with unknown route to ''" do
    @env['unknown_route.js'].to_s.should == "var Bar ='';\n"
  end

  it "works with variables" do
    @env['simple_route_with_variable.js'].to_s.should == "var x = 2;\nvar Bar ='/users/'+x+'';\n"
  end

  it "works with coffeescript" do
    @env['simple_coffee_route.js'].to_s.should == "(function() {\n  var Bar;\n\n  Bar = '/users';\n\n}).call(this);\n"
  end

  it "works with unqualified routes" do
    @env['unqualified_routes.js'].to_s.should == "var url ='/users/{{id}}';\n"
  end

  it "works with partially qualified nested routes" do
    @env['nested_routes.js'].to_s.should == "var project_path ='/projects/'+2+'/tickets/{{id}}';\n"
  end

  it "does not replace false positives" do
    @env['false_positive.js'].to_s.should == "var x = receiver(y);\n";
  end

  it "works as function argument" do
    @env["function_argument.js"].to_s.should == "var url = receiver('/users');\n"
  end

  it "works with function argument" do
    @env["argument_function.js"].to_s.should == "var url ='/users/'+fetchUserId()+'';\n"
  end
end
