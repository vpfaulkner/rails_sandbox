module Components
  class RakedRoutes < Components::Base
    def to_partial_path
      'components/raked_routes'
    end

    def path
      'rake routes'
    end

    def language
      'bash'
    end

    def type
      'routes'
    end

    def code
      set = ActionDispatch::Routing::RouteSet.new
      set.draw(&routes_block)

      inspector = ActionDispatch::Routing::RoutesInspector.new(set.routes)
      inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, nil)
    end

    private

    # Recreate routes block rather than using eval
    def routes_block
      identifier =  resource.singular ? 'resource' : 'resources'
      name = resource.name.to_sym
      namespace = resource.namespace.to_sym
      resource_call = -> { send(identifier, name) }

      lambda do
        if namespace.present?
          send(:namespace, namespace) do
            instance_exec(&resource_call)
          end
        else
          instance_exec(&resource_call)
        end
      end
    end
  end
end
