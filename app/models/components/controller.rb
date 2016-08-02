module Components
  class Controller < Base
    include Ruby

    def to_partial_path
      'components/controller'
    end

    def path
      type_directory + "#{resource.name.pluralize}_controller.rb"
    end

    def type
      'controller'
    end

    def class_name
      super.pluralize + 'Controller'
    end
  end
end
