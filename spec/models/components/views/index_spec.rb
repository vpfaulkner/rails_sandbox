require 'rails_helper'
require_relative '../base_spec.rb'
require_relative 'base_spec.rb'

describe Components::Views::Index, type: :model do
  include_context 'resource'

  it_behaves_like 'a component'
  it_behaves_like 'a view component'

  let(:component) { described_class.new(resource) }

  describe '#to_partial_path' do
    it 'returns the right path' do
      expect(component.to_partial_path).to eq 'components/views/index'
    end
  end

  describe '#path' do
    it 'returns the right path' do
      component.resource.name = 'User'
      component.resource.namespace = 'Admin'
      expect(component.path).to eq('app/views/admin/users/index.html.erb')
    end
  end
end
