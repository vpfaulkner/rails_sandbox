module Components
  def self.from_resource(resource)
    actions = resource.actions

    files = []
    files << Components::Controller.new(resource)
    files << Components::Model.new(resource)
    files << Components::Routes.new(resource)
    files << Components::RakedRoutes.new(resource)
    files << Components::Views::New.new(resource)   if actions.include?(:new)
    files << Components::Views::Show.new(resource)  if actions.include?(:show)
    files << Components::Views::Edit.new(resource)  if actions.include?(:edit)
    files << Components::Views::Index.new(resource) if actions.include?(:index)
    files << Components::Views::Form.new(resource)  if actions.include?(:edit) ||
                                                       actions.include?(:new)
    files
  end
end
