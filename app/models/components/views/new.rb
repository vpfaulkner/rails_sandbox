module Components
  module Views
    class New < Components::Views::Base
      def to_partial_path
        'components/views/new'
      end

      def path
        type_directory + 'new.html.erb'
      end
    end
  end
end
