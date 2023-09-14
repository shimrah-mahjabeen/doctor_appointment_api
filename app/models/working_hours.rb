class WorkingHours < ApplicationRecord
	belongs_to :doctor

	has_many :availabilities
end
