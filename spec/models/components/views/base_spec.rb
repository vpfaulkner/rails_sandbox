require 'rails_helper'
require_relative '../../../shared/resource.rb'

shared_examples_for 'a view component' do
  include_context 'resource'

  let(:component) { described_class.new(resource) }

  describe '#type' do
    it 'returns views' do
      expect(component.type).to eq 'views'
    end
  end

  describe '#language' do
    it 'returns html' do
      expect(component.language).to eq 'html'
    end
  end
end
