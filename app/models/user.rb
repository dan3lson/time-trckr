class User < ApplicationRecord
  include Clearance::User

  # Associations
  has_many :logs, dependent: :destroy
  has_many :tags, dependent: :destroy

  # == Hours for Today
  #
  # The number of hours tracked for today.
  #
  # @return Float
  #
  def hours_for_today
    logs.today.hours_for_today
  end
end
