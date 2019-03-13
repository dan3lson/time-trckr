class Log < ApplicationRecord
  # Associations
  has_many :logs_tags, dependent: :destroy
  has_many :tags,      through: :logs_tags

  # Validations
  validates :name,       presence: true
  validates :started_at, presence: true
  validates :stopped_at, presence: true

  # Scopes
  scope :latest, -> { order(started_at: :desc) }
  scope :today,  -> { where('started_at > ?', Date.today) }

  # == Tags?
  #
  # Checks if this log has any tags.
  #
  # @return Boolean
  #
  def tags?
    tags.any?
  end

  # == Hours
  #
  # The number of hours tracked in this log.
  #
  # @return Float
  #
  def hours
    ((stopped_at - started_at) / 1.hour).round(2)
  end

  # == Hours for Today
  #
  # The number of hours tracked for today.
  #
  # @return Float
  #
  def self.hours_for_today
    today.select(:started_at, :stopped_at).map(&:hours).sum.round(2)
  end
end
