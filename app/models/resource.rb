class Resource
  include ActiveModel::Model
  include ActiveModel::Validations

  CRUD = [:create, :read, :update, :delete]
  VALID_ATTRIBUTE_TYPES = %w(string
                             text
                             binary
                             integer
                             date
                             datetime
                             boolean
                             decimal
                             float
                             time
                             primary_key
                             references
                             timestamp)

  attr_writer :name, :namespace, :crud, :attributes
  attr_accessor :singular

  validates :name, presence: true
  validates_format_of :name, with: /\A[a-zA-Z]*\z/, message: 'must only include letters'
  validates_format_of :namespace, with: /\A[a-zA-Z0-9]*\z/, message: 'must be alphanumeric'
  validates :singular, inclusion: { in: [true, false], message: 'must be true or false' }
  validate :valid_crud?
  validate :valid_attribute_names?
  validate :valid_attribute_types?

  def actions
    set = Set.new
    set.merge(Actions::CREATE) if crud.include? :create
    set.merge(Actions::READ)   if crud.include? :read
    set.merge(Actions::UPDATE) if crud.include? :update
    set.merge(Actions::DELETE) if crud.include? :delete

    set.subtract(Actions::PLURAL) if singular
    set.to_a
  end

  def load_actions
    actions & Actions::LOAD
  end

  def name
    String(@name).underscore
  end

  def namespace
    String(@namespace).underscore
  end

  def crud
    Array(@crud).map(&:to_sym)
  end

  def attributes
    Hash(@attributes).each_with_object({}) do |(k, v), m|
      m[k.underscore.gsub(' ', '_')] = v if v.present?
    end
  end

  private

  def valid_crud?
    errors.add(:crud, 'must be valid type') if (crud - CRUD).present?
  end

  def valid_attribute_names?
    attributes.each do |attribute, _t|
      next if attribute[/\A[a-zA-Z_]+\z/]
      errors.add(:attributes, "#{attribute} must only include letters")
    end
  end

  def valid_attribute_types?
    errors.add(:attributes, 'must be valid type') if attributes.any? do |_a, t|
      !VALID_ATTRIBUTE_TYPES.include? t
    end
  end
end
