require 'spec_helper'

describe AssetPipelineRoutes::Path do
  subject { AssetPipelineRoutes::Path.new '/users/:id/edit(.:format)' }

  describe 'apply_format' do
    it { subject.apply_format({ format: 'json' }).should eql '/users/:id/edit.json' }
    it { subject.apply_format({}).should eql '/users/:id/edit' }
  end

  describe 'format' do
    it { subject.format({ format: 'json' }).should == '.json' }
    it { subject.format({}).should == '' }
  end

  describe 'after applying formats' do
    before { subject.apply_format }

    describe 'number_of_replacements' do
      it { subject.number_of_replacements.should == 1 }
    end

    describe 'default_replacements' do
      it { subject.default_replacements.should eql [AssetPipelineRoutes::Path::DEFAULT_REPLACEMENT]}
    end

    describe 'replacements' do
      it { subject.replacements().should eql subject.default_replacements }
      it { subject.replacements(1).should eql ["'+1+'"] }
    end
  end
end