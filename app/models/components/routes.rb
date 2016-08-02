module Components
  class Routes < Components::Base
    include Ruby

    def to_partial_path
      'components/routes'
    end

    def type
      'routes'
    end

    def path
      'config/routes.rb'
    end
  end
end
