module Components
  module Views
    class Show < Components::Views::Base
      def to_partial_path
        'components/views/show'
      end

      def path
        type_directory + 'show.html.erb'
      end
    end
  end
end
