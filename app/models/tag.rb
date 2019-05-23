class Tag < ApplicationRecord
  # Associations
  belongs_to :user
  has_many   :logs_tags, dependent: :destroy
  has_many   :logs,      through: :logs_tags

  # Validations
  validates :name, presence: true

  # Scopes
  scope :by_name, -> { order(:name) }

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

  # == Hours This Day (user)
  #
  # Calculate how many hours were
  # spent this day for this tag.
  #
  # @return Decimal
  #
  def hours_this_day(user, log)
    start_date = log.started_at.beginning_of_day
    end_date   = start_date.end_of_day
    user.logs_for_tag(self).where(started_at: start_date..end_date).sum_hours
  end
end
