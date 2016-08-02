module Components
  class Base
    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end

    def to_partial_path
      fail 'not implmented'
    end

    def path
      fail 'not implmented'
    end

    def language
      fail 'not implemented'
    end

    def type
      fail 'not implemented'
    end

    private

    def type_directory
      namespace_directory = "#{resource.namespace}/" if resource.namespace.present?
      "app/#{type.pluralize}/#{namespace_directory}"
    end
  end
end
