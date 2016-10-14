require 'rails_helper'
require_relative 'base.rb'

describe Components::RakedRoutes, type: :model do
  include_context 'resource'

  it_behaves_like 'a component'

  let(:component) { described_class.new(resource) }

  describe '#to_partial_path' do
    it 'returns the right path' do
      expect(component.to_partial_path).to eq 'components/raked_routes'
    end
  end

  describe '#path' do
    it 'returns the right path' do
      expect(component.path).to eq 'rake routes'
    end
  end

  describe '#type' do
    it 'returns the right type' do
      expect(component.type).to eq 'routes'
    end
  end

  describe '#language' do
    it 'returns the right language' do
      expect(component.language).to eq 'bash'
    end
  end

  describe '#code' do
    it 'returns the right code' do
      component.resource.name = 'user'
      component.resource.namespace = 'admin'
      expect(component.code).to eq(
"          Prefix Verb   URI Pattern                    Controller#Action\nadmin_user_index GET    /admin/user(.:format)          admin/user#index\n                 POST   /admin/user(.:format)          admin/user#create\n  new_admin_user GET    /admin/user/new(.:format)      admin/user#new\n edit_admin_user GET    /admin/user/:id/edit(.:format) admin/user#edit\n      admin_user GET    /admin/user/:id(.:format)      admin/user#show\n                 PATCH  /admin/user/:id(.:format)      admin/user#update\n                 PUT    /admin/user/:id(.:format)      admin/user#update\n                 DELETE /admin/user/:id(.:format)      admin/user#destroy"
      )
    end
  end
end
