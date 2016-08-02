require 'rails_helper'
require_relative '../../shared/resource.rb'

shared_examples_for 'a component' do
  include_context 'resource'

  let(:component) { described_class.new(resource) }

  describe 'resource' do
    it 'is a getter' do
      expect(component.resource).to eq resource
    end
  end

  describe '#to_partial_path' do
    it 'is implemented' do
      expect { component.to_partial_path }.not_to raise_error
    end
  end

  describe '#path' do
    it 'is implemented' do
      expect { component.path }.not_to raise_error
    end
  end

  describe '#language' do
    it 'is implemented' do
      expect { component.language }.not_to raise_error
    end
  end

  describe '#type' do
    it 'is implemented' do
      expect { component.type }.not_to raise_error
    end
  end
end
