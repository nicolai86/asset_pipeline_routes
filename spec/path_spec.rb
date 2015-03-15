require 'spec_helper'

describe AssetPipelineRoutes::Path do
  subject { AssetPipelineRoutes::Path.new '/users/:id/edit(.:format)' }

  describe 'apply_format' do
    it { expect(subject.apply_format({ format: 'json' })).to eql '/users/:id/edit.json' }
    it { expect(subject.apply_format({})).to eql '/users/:id/edit' }
  end

  describe 'format' do
    it { expect(subject.format({ format: 'json' })).to eql '.json' }
    it { expect(subject.format({})).to eql '' }
  end

  describe 'after applying formats' do
    before { subject.apply_format }

    describe 'number_of_replacements' do
      it { expect(subject.number_of_replacements).to eql 1 }
    end

    describe 'default_replacements' do
      it { expect(subject.default_replacements).to eql [AssetPipelineRoutes::Path::DEFAULT_REPLACEMENT]}
    end

    describe 'replacements' do
      it { expect(subject.replacements()).to eql subject.default_replacements }
      it { expect(subject.replacements(1)).to eql ["'+1+'"] }
    end
  end
end