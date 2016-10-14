require 'rails_helper'
require_relative 'base.rb'
require_relative 'ruby.rb'

describe Components::Controller, type: :model do
  include_context 'resource'

  it_behaves_like 'a component'
  it_behaves_like 'a ruby component'

  let(:component) { described_class.new(resource) }

  describe '#to_partial_path' do
    it 'returns the right path' do
      expect(component.to_partial_path).to eq 'components/controller'
    end
  end

  describe '#path' do
    it 'returns the right path' do
      component.resource.name = 'User'
      component.resource.namespace = 'Admin'
      expect(component.path).to eq('app/controllers/admin/users_controller.rb')
    end
  end

  describe '#type' do
    it 'returns the right type' do
      expect(component.type).to eq 'controller'
    end
  end

  describe '#class_name' do
    it 'returns the right class_name' do
      component.resource.name = 'User'
      expect(component.class_name).to eq 'UsersController'
    end
  end
end
