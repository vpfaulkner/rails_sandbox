require 'rails_helper'
require_relative 'base_spec.rb'
require_relative 'ruby_spec.rb'

describe Components::Model, type: :model do
  include_context 'resource'

  it_behaves_like 'a component'
  it_behaves_like 'a ruby component'

  let(:component) { described_class.new(resource) }

  describe '#to_partial_path' do
    it 'returns the right path' do
      expect(component.to_partial_path).to eq 'components/model'
    end
  end

  describe '#path' do
    it 'returns the right path' do
      component.resource.name = 'User'
      component.resource.namespace = 'Admin'
      expect(component.path).to eq('app/models/admin/user.rb')
    end
  end

  describe '#type' do
    it 'returns the right type' do
      expect(component.type).to eq 'model'
    end
  end

  describe '#parent_class_name' do
    it 'returns the right class_name' do
      expect(component.parent_class_name).to eq 'ApplicationRecord'
    end
  end
end
