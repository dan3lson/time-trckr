class Tag < ApplicationRecord
  # Associations
  has_many :logs_tags, dependent: :destroy
  has_many :logs,      through: :logs_tags

  # Validations
  validates :name, presence: true
end
