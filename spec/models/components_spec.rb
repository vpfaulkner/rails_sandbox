require 'rails_helper'
require_relative '../shared/resource.rb'

describe Components do
  include_context 'resource'

  describe '.from_resource' do
    context 'when new action' do
      it 'returns appropriate components' do
        allow(resource).to receive(:actions).and_return [:new]
        components = Components.from_resource(resource)
        expect(components.map(&:class)).to eq(
          [Components::Controller,
           Components::Model,
           Components::Routes,
           Components::RakedRoutes,
           Components::Views::New,
           Components::Views::Form]
        )
      end
    end

    context 'when show action' do
      it 'returns appropriate components' do
        allow(resource).to receive(:actions).and_return [:show]
        components = Components.from_resource(resource)
        expect(components.map(&:class)).to eq(
          [Components::Controller,
           Components::Model,
           Components::Routes,
           Components::RakedRoutes,
           Components::Views::Show]
        )
      end
    end

    context 'when edit action' do
      it 'returns appropriate components' do
        allow(resource).to receive(:actions).and_return [:edit]
        components = Components.from_resource(resource)
        expect(components.map(&:class)).to eq(
          [Components::Controller,
           Components::Model,
           Components::Routes,
           Components::RakedRoutes,
           Components::Views::Edit,
           Components::Views::Form]
        )
      end
    end

    context 'when index action' do
      it 'returns appropriate components' do
        allow(resource).to receive(:actions).and_return [:index]
        components = Components.from_resource(resource)
        expect(components.map(&:class)).to eq(
          [Components::Controller,
           Components::Model,
           Components::Routes,
           Components::RakedRoutes,
           Components::Views::Index]
        )
      end
    end
  end
end
