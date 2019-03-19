class User < ApplicationRecord
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

  # == Weekly Summary
  #
  # The number of hours tracked for today.
  #
  # @return Hash
  #
  def weekly_summary
    logs.last_week.latest.group_by { |log| log.started_at.beginning_of_day }
  end
end
