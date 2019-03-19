class WeeklySummaryJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      UserMailer.weekly_summary(user).deliver_later
    end
  end
end
