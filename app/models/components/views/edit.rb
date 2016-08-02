module Components
  module Views
    class Edit < Components::Views::Base
      def to_partial_path
        'components/views/edit'
      end

      def path
        type_directory + 'edit.html.erb'
      end
    end
  end
end
