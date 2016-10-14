require 'rails_helper'
require_relative 'base.rb'
require_relative 'ruby.rb'

describe Components::Routes, type: :model do
  include_context 'resource'
  it_behaves_like 'a ruby component'

  it_behaves_like 'a component'

  let(:component) { described_class.new(resource) }

  describe '#to_partial_path' do
    it 'returns the right path' do
      expect(component.to_partial_path).to eq 'components/routes'
    end
  end

  describe '#path' do
    it 'returns the right path' do
      expect(component.path).to eq 'config/routes.rb'
    end
  end

  describe '#type' do
    it 'returns the right type' do
      expect(component.type).to eq 'routes'
    end
  end
end
