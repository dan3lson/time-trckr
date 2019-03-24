class Log < ApplicationRecord
  # Associations
  belongs_to :user
  has_many   :logs_tags,   dependent: :destroy
  has_many   :tags,        through: :logs_tags

  # Validations
  validates :name,         presence: true
  validates :started_at,   presence: true
  validates :stopped_at,   presence: true

  # Scopes
  scope :latest,     -> { order(created_at: :desc) }
  scope :earliest,   -> { order(created_at: :asc) }
  scope :today,      -> {
    where('started_at > ?', Time.current.beginning_of_day)
  }
  scope :this_week,  -> { where(
    'logs.created_at >= ? AND logs.created_at <= ?',
    Time.current.beginning_of_week,
    Time.current.end_of_week
  )}
  scope :last_week,  -> { where(
    'logs.created_at >= ? AND logs.created_at <= ?',
    Time.current.last_week,
    Time.current.last_week.end_of_week
  )}

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
  # The number of hours tracked for this
  # log.
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
