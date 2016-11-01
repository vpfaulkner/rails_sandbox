class SandboxChannel < ApplicationCable::Channel
  delegate :broadcast, to: 'ActionCable.server'
  delegate :render,    to: 'ApplicationController.renderer'

  def subscribed
    stream_from connection_id

    @resource = Resource.new
  end

  def update(data)
    data['input'].each { |field, value| @resource.send("#{field}=", value) }

    if @resource.valid?
      # Broadcast for each type with current type first
      types(data['active_type']).each do |type|
        broadcast(connection_id, output: components(type))
      end
      # broadcast(connection_id, output: output)
    else
      broadcast(connection_id, errors: @resource.errors.to_hash(true))
    end
  end

  private

  def types(active_type)
    ts = Components.types
    ts.insert(0, ts.delete(active_type))
  end

  def components(type)
    Components.from_type(@resource, type).each_with_object(Hash.new('')) do |component, partials|
      partials[type] += render component, layout: 'component', as: 'component', locals: { resource: @resource }
    end
  end

  # def output
  #   components.each_with_object(Hash.new('')) do |component, partials|
  #     partials[component.type] += render component, layout: 'component', as: 'component', locals: { resource: @resource }
  #   end
  # end

  # def output
  #   components.each_with_object(Hash.new('')) do |component, partials|
  #     partials[component.type] += render component, layout: 'component', as: 'component', locals: { resource: @resource }
  #   end
  # end
  #
  # def components
  #   Components.from_resource(@resource)
  # end
end
