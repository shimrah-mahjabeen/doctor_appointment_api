class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: 'User'
  belongs_to :patient, class_name: 'User'
  belongs_to :availability

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :availability_id, uniqueness: true
end
