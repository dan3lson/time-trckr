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

  # == Tag? (tag)
  #
  # Checks if this log has a
  # specific tag.
  #
  # @return Boolean
  #
  def tag?(tag)
    tags.include?(tag)
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

  # == Minutes
  #
  # The number of minutes tracked for this
  # log.
  #
  # @return Float
  #
  def minutes
    (hours * 60).round(0)
  end

  # == Hours for Today
  #
  # The number of hours tracked for today.
  #
  # @return Float
  #
  def self.hours_for_today
    today.sum_hours
  end

  # == Sum Hours
  #
  # The added hours for the chained logs.
  #
  # @return Float
  #
  def self.sum_hours
    select(:started_at, :stopped_at).map(&:hours).sum.round(2)
  end

  # == Convert (unit)
  #
  # Determine the next unit
  # to display:
  # - If hours currently show, switch to
  #   minutes
  # - If minutes currently show, switch
  #   to total hours
  # - If total hours currently show, go
  #   back to hours.
  #
  # @return String
  #
  def self.convert(unit)
    if unit == 'hours'
      'minutes'
    elsif unit == 'minutes'
      'hours_for_today'
    elsif unit == 'hours_for_today'
      'total_hours'
    elsif unit == 'total_hours'
      'hours'
    end
  end

  # == Total Hours
  #
  # Find logs with the same name, i.e.
  # things a user did multiple times,
  # and add all of their hours worked.
  #
  # @return Float
  #
  def total_hours(user)
    user.logs.where(name: name).sum_hours
  end

  # == Hours For Today (user)
  #
  # Find logs with the same name, i.e.
  # things a user did multiple times,
  # and add all of their hours worked
  # for today.
  #
  # @return Float
  #
  def hours_for_today(user)
    user.logs.today.where(name: name).sum_hours
  end
end
