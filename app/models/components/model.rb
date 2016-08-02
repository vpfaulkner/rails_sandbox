module Components
  class Model < Base
    include Ruby

    def to_partial_path
      'components/model'
    end

    def path
      type_directory + "#{resource.name}.rb"
    end

    def type
      'model'
    end

    def parent_class_name
      'ApplicationRecord'
    end
  end
end
