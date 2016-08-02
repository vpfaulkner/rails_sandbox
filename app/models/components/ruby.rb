module Components
  module Ruby
    def language
      'ruby'
    end

    def class_name
      resource.name.classify
    end

    def module_name
      resource.namespace.classify if resource.namespace.present?
    end

    def parent_class_name; end
  end
end
