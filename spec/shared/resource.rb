require 'rails_helper'

RSpec.shared_context 'resource' do
  let(:name) { 'user' }
  let(:namespace) { 'admin' }
  let(:crud) { [:create, :read, :delete] }
  let(:singular) { false }
  let(:attributes) { { 'age' => 'integer' } }
  let(:resource) do
    Resource.new(name: name,
                 namespace: namespace,
                 crud: crud,
                 singular: singular,
                 attributes: attributes)
  end
end
