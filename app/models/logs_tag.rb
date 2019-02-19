class LogsTag < ApplicationRecord
  # Associations
  belongs_to :log
  belongs_to :tag
end
