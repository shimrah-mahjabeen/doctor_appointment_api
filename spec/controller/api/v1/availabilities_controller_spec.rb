require 'rails_helper'

RSpec.describe Api::V1::AvailabilitiesController, type: :controller do
  let(:doctor) do
    Doctor.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: 'password123'
    )
  end

  let(:patient) do
    Patient.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: 'password123'
    )
  end

  let(:working_hours) do
    WorkingHours.create(
      start_time: Time.current - 10.hours,
      end_time: Time.current + 4.hours,
      doctor: doctor
    )
  end

  let!(:availability) do
    Availability.create(
      start_time: Time.current,
      end_time: Time.current + 2.hours,
      booked: false,
      doctor: doctor,
      working_hours_id: working_hours.id
    )
  end

  before do
    request.headers.merge! patient.create_new_auth_token
  end

  describe 'GET #index' do
    it 'returns a list of availabilities for the doctor' do
      get :index, params: { doctor_id: doctor.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(availability.to_json)
    end

    it 'returns an empty list if no availabilities exist' do
      Availability.destroy_all
      get :index, params: { doctor_id: doctor.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('[]')
    end
  end

  describe 'GET #open_slots' do
    it 'returns a list of open slots for the doctor' do
      get :open_slots, params: { doctor_id: doctor.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to match(availability.to_json)
    end

    it 'returns an empty list if no open slots exist' do
      Availability.destroy_all
      get :open_slots, params: { doctor_id: doctor.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('[]')
    end
  end
end
