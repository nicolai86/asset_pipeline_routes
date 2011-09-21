require 'spec_helper'

describe HandlebarsRoutesAssets do
  # the @route property basically describes a RouteSet#routes object
  # as Rails.application.routes.routes[:index] returns it
  describe 'resources#index' do
    before { @route = OpenStruct.new({:name => 'users', :path => '/users(.:format)'}) }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }

    it { should respond_to(:users_path) }
    its(:users_path) { should eql('/users') }
  end

  describe 'resources#show' do
    before { @route = OpenStruct.new({:name => 'user', :path => '/users/:id(.:format)'}) }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }

    it { should respond_to(:user_path) }
    its(:user_path) { should eql('/users/{{id}}') }
  end

  describe 'resources#edit' do
    before { @route = OpenStruct.new({:name => 'edit_user', :path => '/users/:id/edit(.:format)'}) }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }

    it { should respond_to(:edit_user_path) }
    its(:edit_user_path) { should eql('/users/{{id}}/edit') }
  end
end