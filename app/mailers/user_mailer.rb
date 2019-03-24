# frozen_string_literal: true

# == User Mailer
#
# Emails sent to users
#
class UserMailer < ApplicationMailer
  default template_path: "mailers/#{name.underscore}"

  # == Welcome
  #
  # Greet new users after they sign up
  # for the first time.
  #
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to TimeTrckr.com')
  end

  # == Weekly Summary
  #
  # Let users know what they logged last
  # week. This is sent every Monday at
  # 8:30am.
  #
  def logs_last_week(user)
    @user = user
    mail(to: @user.email, subject: 'TimeTrckr.com: Your Logs from Last Week')
  end
end
