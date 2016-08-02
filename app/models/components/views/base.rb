module Components
  module Views
    class Base < Components::Base
      def type
        'views'
      end

      def language
        'html'
      end

      private

      def type_directory
        super + "#{resource.name.pluralize}/"
      end
    end
  end
end
