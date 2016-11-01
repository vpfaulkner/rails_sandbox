require 'rails_helper'
require_relative '../shared/resource.rb'

describe Components do
  include_context 'resource'

  describe '.types' do
    it 'returns array of types' do
      expect(Components.types).to eq ['controller', 'model', 'views', 'routes']
    end
  end

  describe '.from_type' do
    it 'returns controller component' do
      components = Components.for_type(resource, 'controller')

      expect(components.size).to eq 1
      expect(components.first.class).to eq Components::Controller
      expect(components.first.resource).to eq resource
    end

    it 'returns the model compoent' do
      components = Components.for_type(resource, 'model')

      expect(components.size).to eq 1
      expect(components.first.class).to eq Components::Model
      expect(components.first.resource).to eq resource
    end

    it 'returns the routes compoent' do
      components = Components.for_type(resource, 'routes')

      expect(components.size).to eq 2
      expect(components.first.class).to eq Components::Routes
      expect(components.first.resource).to eq resource
      expect(components.last.class).to eq Components::RakedRoutes
      expect(components.last.resource).to eq resource
    end

    context 'when new action' do
      it 'returns the right view compoent' do
        allow(resource).to receive(:actions).and_return [:new]

        components = Components.for_type(resource, 'views')
        expect(components.size).to eq 2
        expect(components.first.class).to eq Components::Views::New
        expect(components.first.resource).to eq resource
        expect(components.last.class).to eq Components::Views::Form
        expect(components.last.resource).to eq resource
      end
    end

    context 'when show action' do
      it 'returns the right view compoent' do
        allow(resource).to receive(:actions).and_return [:show]

        components = Components.for_type(resource, 'views')
        expect(components.size).to eq 1
        expect(components.first.class).to eq Components::Views::Show
        expect(components.first.resource).to eq resource
      end
    end

    context 'when edit action' do
      it 'returns the right view compoent' do
        allow(resource).to receive(:actions).and_return [:edit]

        components = Components.for_type(resource, 'views')
        expect(components.size).to eq 2
        expect(components.first.class).to eq Components::Views::Edit
        expect(components.first.resource).to eq resource
        expect(components.last.class).to eq Components::Views::Form
        expect(components.last.resource).to eq resource
      end
    end

    context 'when index action' do
      it 'returns the right view compoent' do
        allow(resource).to receive(:actions).and_return [:index]

        components = Components.for_type(resource, 'views')
        expect(components.size).to eq 1
        expect(components.first.class).to eq Components::Views::Index
        expect(components.first.resource).to eq resource
      end
    end
  end
end
