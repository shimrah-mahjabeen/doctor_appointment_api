class Doctor < User
  has_many :availabilities
  has_many :working_hours, class_name: 'WorkingHours'
  has_many :appointments, foreign_key: 'doctor_id', dependent: :destroy
end
