module Components
  module Views
    class Index < Components::Views::Base
      def to_partial_path
        'components/views/index'
      end

      def path
        type_directory + 'index.html.erb'
      end
    end
  end
end
