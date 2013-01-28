require 'spec_helper'

def build_route name, path
  OpenStruct.new({:name => name, :path => OpenStruct.new(:ast => path)})
end

describe AssetPipelineRoutes::Routes do
  # the @route property basically describes a RouteSet#routes object
  # as Rails.application.routes.routes[:index] returns it
  describe 'resources#index' do
    before { @route = build_route 'users', '/users(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:users_path) }
    its(:users_path) { should eql '/users'}
    it { subject.users_path('\d+').should eql('/users') }

    describe "with format" do
      it { subject.users_path(format: 'json').should eql('/users.json') }
    end
  end

  describe 'resources#show' do
    before { @route = build_route 'user', '/users/:id(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:user_path) }
    its(:user_path) { should eql('/users/{{id}}') }
    it { subject.user_path('\d+').should eql('/users/\d+') }

    describe "with format" do
      it { subject.user_path('\d+', format: 'json').should eql('/users/\d+.json') }
      it { subject.user_path(42, format: 'xml').should eql('/users/42.xml') }
    end
  end

  describe 'resources#edit' do
    before { @route = build_route 'edit_user', '/users/:id/edit(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:edit_user_path) }
    its(:edit_user_path) { should eql('/users/{{id}}/edit') }
    it { subject.edit_user_path('\d+').should eql('/users/\d+/edit') }

    describe "with format" do
      it { subject.edit_user_path('\d+', format: 'json').should eql('/users/\d+/edit.json') }
      it { subject.edit_user_path(42, format: 'xml').should eql('/users/42/edit.xml') }
    end
  end

  describe 'nested routes' do
    before { @route = build_route 'project_ticket', '/projects/:project_id/tickets/:id(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:project_ticket_path) }
    its(:project_ticket_path) {should eql('/projects/{{project_id}}/tickets/{{id}}') }
    it { subject.project_ticket_path(1,'\d+').should eql('/projects/1/tickets/\d+') }
    it { subject.project_ticket_path('\d+',2).should eql('/projects/\d+/tickets/2') }
    it { subject.project_ticket_path(1,2).should eql('/projects/1/tickets/2') }
    it { subject.project_ticket_path(1,2,3).should eql('/projects/1/tickets/2') }

    describe "with format" do
      it { subject.project_ticket_path("a","b",format: 'json').should eql('/projects/a/tickets/b.json') }
      it { subject.project_ticket_path("a", format: 'json').should eql('/projects/a/tickets/{{id}}.json') }
    end
  end

  describe 'javascript method generation' do
    before { @route = build_route 'user', '/users/:id/edit(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:user_path_method) }

    it "should generate JavaScript mapping method" do
      js_method = "(function() { return function (id) { return '/users/' + id + '/edit' }; }).call(this);"
      subject.edit_user_path_method.should eql(js_method)
    end

    it "should generate CoffeScript mapping method" do
      coffee_method = "(-> (id) -> '/users/' + id + '/edit')(this)"
      subject.edit_user_path_method(:coffee).should eql(coffee_method)
    end

    context 'nested routes' do
      before { @route = build_route 'project_ticket', '/projects/:project_id/tickets/:id(.:format)' }
      subject { AssetPipelineRoutes::Routes.new [@route] }

      it "should generate CoffeScript mapping method" do
        coffee_method = "(-> (projectId, id) -> '/projects/' + projectId + '/tickets/' + id)(this)"
        subject.project_ticket_path_method(:coffee).should eql(coffee_method)
      end

      it "should generate JavaScript mapping method" do
        js_method = "(function() { return function (projectId, id) { return '/projects/' + projectId + '/tickets/' + id }; }).call(this);"
        subject.project_ticket_path_method.should eql(js_method)
      end
    end
  end
end
