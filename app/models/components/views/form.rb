module Components
  module Views
    class Form < Components::Views::Base
      def to_partial_path
        'components/views/form'
      end

      def path
        type_directory + '_form.html.erb'
      end
    end
  end
end
