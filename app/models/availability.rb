class Availability < ApplicationRecord
  belongs_to :doctor
  belongs_to :working_hours

  has_one :appointment

  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :timing_in_working_hours

  private

  def timing_in_working_hours
    return if start_time >= working_hours.start_time && end_time <= working_hours.end_time

    errors.add(:base, 'Start and End time should be in working hours')
  end
end
