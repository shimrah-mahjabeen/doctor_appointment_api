def self.generate_time_slots(start_time, end_time, interval_minutes)
  time_slots = []
  current_time = start_time

  while current_time < end_time
    time_slots << current_time
    current_time += interval_minutes.minutes
  end

  time_slots
end

# Define the start and end times for availability slots
availability_start_time = Time.current - 7.hours
availability_end_time = Time.current - 2.hours

# Generate availability slots in 30-minute intervals
availability_time_slots = generate_time_slots(availability_start_time, availability_end_time, 30)

# Create users (doctors and patients)
doctor = Doctor.create!(
  name: 'Doctor1',
  email: 'doctor@example.com',
  password: 'password123',
)

patient = Patient.create!(
  name: 'Patient1',
  email: 'patient@example.com',
  password: 'password123',
)

working_hours = WorkingHours.create!(
  start_time: Time.current - 9.hours,
  end_time: Time.current,
  doctor: doctor
)

# Create availability slots for the doctor
availability_time_slots.each do |start_time|
  end_time = start_time + 30.minutes

  Availability.create!(
    start_time: start_time,
    end_time: end_time,
    doctor: doctor,
    booked: false,
    working_hours_id: working_hours.id
  )
end

# Book some appointments
appointment1 = Availability.first.create_appointment(
  start_time: availability_time_slots[0],
  end_time: availability_time_slots[0] + 30.minutes,
  doctor: doctor,
  patient: patient,
)

appointment2 = Availability.second.create_appointment(
  start_time: availability_time_slots[3],
  end_time: availability_time_slots[3] + 30.minutes,
  doctor: doctor,
  patient: patient,
)

puts 'Seed data created successfully!'
