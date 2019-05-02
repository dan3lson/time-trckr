class User < ApplicationRecord
  # Authentication
  include Clearance::User

  # Associations
  has_many :logs, dependent: :destroy
  has_many :tags, dependent: :destroy

  # Scopes
  scope :latest,     -> { order(created_at: :desc) }
  scope :this_week,  -> { where(
    'users.created_at >= ? AND users.created_at <= ?',
    Time.current.beginning_of_week,
    Time.current.end_of_week
  )}

  # == Hours for Today
  #
  # The number of hours tracked for today.
  #
  # @return Float
  #
  def hours_for_today
    logs.today.hours_for_today
  end

  # == Logs Last Week
  #
  # Group hours by day from last
  # week. Used in LogsLastWeekJob.
  #
  # @return Hash
  #
  def logs_last_week
    logs.last_week.earliest.group_by { |log| log.started_at.beginning_of_day }
  end

  # == Weekly Logs (num_weeks_ago)
  #
  # Group logs by day for the
  # given week. Used in histories#index.
  #
  # @return Hash
  #
  def weekly_logs(num_weeks_ago = 0)
    logs.history(num_weeks_ago: num_weeks_ago)
        .latest
        .group_by { |log| log.started_at.beginning_of_day }
  end

  # == Logs Today?
  #
  # Check if user has logged
  # anything today. Used in
  # logs#index.
  #
  # @return Boolean
  #
  def logs_today?
    hours_for_today.positive?
  end

  # == Logs This Week?
  #
  # Check if user has logged
  # anything this week. Used in
  # histories#index.
  #
  # @return Boolean
  #
  def logs_this_week?
    weekly_logs.any?
  end

  # == Faux Name
  #
  # Name the user from its email
  # address.
  #
  # @return String
  #
  def faux_name
    email.split('@').first
  end

  # == Hours (logs)
  #
  # Add all the hours for the
  # given logs.
  #
  # @return Float
  #
  def hours(logs)
    logs.map(&:hours).sum.round(2)
  end

  # == Tags?
  #
  # See if user has any tags.
  #
  # @return Boolean
  #
  def tags?
    tags.any?
  end
end
