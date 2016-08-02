require 'rails_helper'
require_relative '../shared/resource.rb'

describe Resource, type: :model do
  include_context 'resource'

  describe 'resource attributes' do
    describe 'name' do
      it 'is always an lowercase string' do
        resource.name = 'Name'
        expect(resource.name).to eq 'name'
        resource.name = nil
        expect(resource.name).to eq ''
      end
    end

    describe 'namespace' do
      it 'is always an lowercase string' do
        resource.namespace = 'Namespace'
        expect(resource.namespace).to eq 'namespace'
        resource.namespace = nil
        expect(resource.namespace).to eq ''
      end
    end

    describe 'crud' do
      it 'is always an array of symbols' do
        resource.crud = ['create']
        expect(resource.crud).to eq [:create]
        resource.crud = nil
        expect(resource.crud).to eq []
      end
    end

    describe 'attributes' do
      it 'is a hash of snakecase attributes' do
        resource.attributes = { 'Age' => 'integer', '' => '' }
        expect(resource.attributes).to eq 'age' => 'integer'
        resource.attributes = { 'Last Name' => 'string' }
        expect(resource.attributes).to eq 'last_name' => 'string'
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_inclusion_of(:singular).in_array([true, false]) }

    it 'validates name format' do
      resource.name = 'puts ENV;'
      expect(resource.valid?).to eq false
      expect(resource.errors[:name]).to include 'must only include letters'
    end

    it 'validates the namespace format' do
      resource.namespace = nil
      expect(resource.valid?).to eq true
      resource.namespace = 'Namspace'
      expect(resource.valid?).to eq true
      resource.namespace = 'V1'
      expect(resource.valid?).to eq true
      resource.namespace = 'V!'
      expect(resource.valid?).to eq false
      expect(resource.errors[:namespace]).to include 'must be alphanumeric'
    end

    it 'valiates crud' do
      resource.crud = nil
      expect(resource.valid?).to eq true
      resource.crud = ['create']
      expect(resource.valid?).to eq true
      resource.crud = [:bad]
      expect(resource.valid?).to eq false
      expect(resource.errors[:crud]).to include 'must be valid type'
    end

    it 'valiates attribute names' do
      resource.attributes = nil
      expect(resource.valid?).to eq true
      resource.attributes = { 'Age' => 'integer' }
      expect(resource.valid?).to eq true
      resource.attributes = { 'Last Name' => 'string' }
      expect(resource.valid?).to eq true
      resource.attributes = { 'Ag*e' => 'integer' }
      expect(resource.valid?).to eq false
      expect(resource.errors[:attributes]).to include 'ag*e must only include letters'
    end

    it 'valiates attribute types' do
      resource.attributes = { 'Age' => 'bad' }
      expect(resource.valid?).to eq false
      expect(resource.errors[:attributes]).to include 'must be valid type'
    end
  end

  describe 'actions' do
    context 'when singular' do
      before(:each) do
        resource.singular = true
      end

      context 'when create' do
        it 'includes create actions' do
          resource.crud = [:create]
          expect(resource.actions).to eq Actions::CREATE
        end
      end

      context 'when read' do
        it 'includes read actions' do
          resource.crud = [:read]
          expect(resource.actions).to eq(Actions::READ - Actions::PLURAL)
        end
      end

      context 'when update' do
        it 'includes update actions' do
          resource.crud = [:update]
          expect(resource.actions).to eq Actions::UPDATE
        end
      end

      context 'when delete' do
        it 'includes delete actions' do
          resource.crud = [:delete]
          expect(resource.actions).to eq Actions::DELETE
        end
      end
    end

    context 'when plural' do
      it 'includes plural actions' do
        resource.crud = []
        resource.singular = false
        expect(resource.actions).to eq []
      end
    end
  end

  describe 'load_actions' do
    it 'returns load actions' do
      resource.crud = [:read]
      expect(resource.load_actions).to eq [:show]
    end
  end
end
