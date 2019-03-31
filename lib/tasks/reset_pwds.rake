# frozen_string_literal: true

#  Enables you to run `rails db:reset_pwds`
namespace :db do
  desc 'Reset user passwords in the dev environment.'
  task reset_pwds: :environment do
    User.all.update(password: 'password') if Rails.env == 'development'
  end
end
