class LogsLastWeekJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      UserMailer.logs_last_week(user).deliver_later
    end
  end
end
