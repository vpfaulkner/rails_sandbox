require 'rails_helper'
require_relative '../../shared/resource.rb'

shared_examples_for 'a ruby component' do
  include_context 'resource'

  let(:component) { described_class.new(resource) }

  describe '#language' do
    it 'is ruby' do
      expect(component.language).to eq 'ruby'
    end
  end

  describe '#class_name' do
    it 'is properly formatted' do
      component.resource.name = 'user'
      expect(component.class_name).to eq('User') unless defined? :class_name # Allow for override
    end
  end

  describe '#module_name' do
    context 'if namespace' do
      it 'is properly formatted' do
        component.resource.namespace = 'admin'
        expect(component.module_name).to eq 'Admin'
      end
    end

    context 'if no namespace' do
      it 'returns nil' do
        component.resource.namespace = ''
        expect(component.module_name).to eq nil
      end
    end
  end

  describe '#parent_class_name' do
    it 'is defined' do
      expect { component.parent_class_name }.not_to raise_error
    end
  end
end
