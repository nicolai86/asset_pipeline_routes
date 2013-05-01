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
    its(:users_path) { should eql "'/users'"}
    it { subject.users_path('42').should eql("'/users'") }

    describe "with format" do
      it { subject.users_path(format: 'json').should eql("'/users.json'") }
    end
  end

  describe 'resources#show' do
    before { @route = build_route 'user', '/users/:id(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:user_path) }
    its(:user_path) { should eql("'/users/{{id}}'") }
    it { subject.user_path('42').should eql("'/users/'+42+''") }

    describe "with format" do
      it { subject.user_path("'42'", format: 'json').should eql("'/users/'+'42'+'.json'") }
      it { subject.user_path(42, format: 'xml').should eql("'/users/'+42+'.xml'") }
    end
  end

  describe 'resources#edit' do
    before { @route = build_route 'edit_user', '/users/:id/edit(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:edit_user_path) }
    its(:edit_user_path) { should eql("'/users/{{id}}/edit'") }
    it { subject.edit_user_path('42').should eql("'/users/'+42+'/edit'") }

    describe "with format" do
      it { subject.edit_user_path('42', format: 'json').should eql("'/users/'+42+'/edit.json'") }
      it { subject.edit_user_path(42, format: 'xml').should eql("'/users/'+42+'/edit.xml'") }
    end
  end

  describe 'nested routes' do
    before { @route = build_route 'project_ticket', '/projects/:project_id/tickets/:id(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:project_ticket_path) }
    its(:project_ticket_path) {should eql("'/projects/{{project_id}}/tickets/{{id}}'") }
    it { subject.project_ticket_path(1).should eql("'/projects/'+1+'/tickets/{{id}}'") }
    it { subject.project_ticket_path('x',2).should eql("'/projects/'+x+'/tickets/'+2+''") }
    it { subject.project_ticket_path(1,2).should eql("'/projects/'+1+'/tickets/'+2+''") }
    it { subject.project_ticket_path(1,2,3).should eql("'/projects/'+1+'/tickets/'+2+''") }

    describe "with format" do
      it { subject.project_ticket_path("a","b",format: 'json').should eql("'/projects/'+a+'/tickets/'+b+'.json'") }
      it { subject.project_ticket_path("a", format: 'json').should eql("'/projects/'+a+'/tickets/{{id}}.json'") }
    end
  end
end
