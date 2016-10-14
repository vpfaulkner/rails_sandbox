require 'rails_helper'
require_relative '../base.rb'
require_relative 'base.rb'

describe Components::Views::Edit, type: :model do
  include_context 'resource'

  it_behaves_like 'a component'
  it_behaves_like 'a view component'

  let(:component) { described_class.new(resource) }

  describe '#to_partial_path' do
    it 'returns the right path' do
      expect(component.to_partial_path).to eq 'components/views/edit'
    end
  end

  describe '#path' do
    it 'returns the right path' do
      component.resource.name = 'User'
      component.resource.namespace = 'Admin'
      expect(component.path).to eq('app/views/admin/users/edit.html.erb')
    end
  end
end
