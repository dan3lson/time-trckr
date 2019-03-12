# frozen_string_literal: true

# Create logs and a tag for each one
10.times do |i|
  log = Log.create!(
    name: "Log name +#{i}",
    started_at: 10.minutes.ago,
    stopped_at: Time.current
  )
  log.tags.create!(name: "Tag name +#{i}") if i.even?
end
