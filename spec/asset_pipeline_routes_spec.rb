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
    it { expect(subject.users_path).to eql "'/users'"}
    it { expect(subject.users_path('42')).to eql("'/users'") }

    describe "with format" do
      it { expect(subject.users_path(format: 'json')).to eql("'/users.json'") }
    end
  end

  describe 'resources#show' do
    before { @route = build_route 'user', '/users/:id(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:user_path) }
    it { expect(subject.user_path).to eql("'/users/{{id}}'") }
    it { expect(subject.user_path('42')).to eql("'/users/'+42+''") }

    describe "with format" do
      it { expect(subject.user_path("'42'", format: 'json')).to eql("'/users/'+'42'+'.json'") }
      it { expect(subject.user_path(42, format: 'xml')).to eql("'/users/'+42+'.xml'") }
    end
  end

  describe 'resources#edit' do
    before { @route = build_route 'edit_user', '/users/:id/edit(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:edit_user_path) }
    it { expect(subject.edit_user_path).to eql("'/users/{{id}}/edit'") }
    it { expect(subject.edit_user_path('42')).to eql("'/users/'+42+'/edit'") }

    describe "with format" do
      it { expect(subject.edit_user_path('42', format: 'json')).to eql("'/users/'+42+'/edit.json'") }
      it { expect(subject.edit_user_path(42, format: 'xml')).to eql("'/users/'+42+'/edit.xml'") }
    end
  end

  describe 'nested routes' do
    before { @route = build_route 'project_ticket', '/projects/:project_id/tickets/:id(.:format)' }
    subject { AssetPipelineRoutes::Routes.new [@route] }

    it { should respond_to(:project_ticket_path) }
    it { expect(subject.project_ticket_path).to eql("'/projects/{{project_id}}/tickets/{{id}}'") }
    it { expect(subject.project_ticket_path(1)).to eql("'/projects/'+1+'/tickets/{{id}}'") }
    it { expect(subject.project_ticket_path('x',2)).to eql("'/projects/'+x+'/tickets/'+2+''") }
    it { expect(subject.project_ticket_path(1,2)).to eql("'/projects/'+1+'/tickets/'+2+''") }
    it { expect(subject.project_ticket_path(1,2,3)).to eql("'/projects/'+1+'/tickets/'+2+''") }

    describe "with format" do
      it { expect(subject.project_ticket_path("a","b",format: 'json')).to eql("'/projects/'+a+'/tickets/'+b+'.json'") }
      it { expect(subject.project_ticket_path("a", format: 'json')).to eql("'/projects/'+a+'/tickets/{{id}}.json'") }
    end
  end
end
