class Tag < ApplicationRecord
  # Associations
  belongs_to :user
  has_many   :logs_tags, dependent: :destroy
  has_many   :logs,      through: :logs_tags

  # Validations
  validates :name, presence: true

  # Scopes
  scope :a_to_z, -> { order(:name) }

  # == Initializer
  #
  # Build new tag objects from
  # the given comma-separated
  # string
  #
  def self.initializer(user, names)
    names.split(',')
         .reject(&:blank?)
         .uniq
         .map { |name| user.tags.new(name: name) }
  end
end
