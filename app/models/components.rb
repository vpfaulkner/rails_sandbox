module Components
  def self.types
    %w(controller model views routes)
  end

  def self.for_type(resource, type)
    actions = resource.actions

    files = []

    case type
    when 'controller'
      files << Components::Controller.new(resource)
    when 'model'
      files << Components::Model.new(resource)
    when 'routes'
      files << Components::Routes.new(resource)
      files << Components::RakedRoutes.new(resource)
    when 'views'
      files << Components::Views::New.new(resource)   if actions.include?(:new)
      files << Components::Views::Show.new(resource)  if actions.include?(:show)
      files << Components::Views::Edit.new(resource)  if actions.include?(:edit)
      files << Components::Views::Index.new(resource) if actions.include?(:index)
      files << Components::Views::Form.new(resource)  if actions.include?(:edit) ||
                                                         actions.include?(:new)
    end

    files
  end
end
