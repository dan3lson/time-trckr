class Tag < ApplicationRecord
	# Associations
	has_many :logs_tags
	has_many :logs, through: :logs_tags
end
