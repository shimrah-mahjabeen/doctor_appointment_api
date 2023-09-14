require 'rails_helper'

RSpec.describe Api::V1::AppointmentsController, type: :controller do
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

  let(:valid_attributes) do
    {
      start_time: availability.start_time,
      end_time: availability.end_time,
      doctor_id: doctor.id,
      availability_id: availability.id
    }
  end

  before do
    request.headers.merge! patient.create_new_auth_token
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new appointment' do
        expect do
          post :create, params: valid_attributes
        end.to change(Appointment, :count).by(1)
      end

      it 'marks the availability as created' do
        post :create, params: valid_attributes
        availability.reload
        expect(availability.booked).to be(true)
      end

      it 'returns a JSON response with status :created' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'when params are invalid' do
      it 'returns a JSON response with an error message' do
        post :create, params: { doctor_id: doctor.id, availability_id: 33 }

        expect(JSON.parse(response.body)).to include('errors' => ['Availability not found'])
      end
    end
  end

  describe 'PATCH #update' do
    let!(:appointment) do
      Appointment.create(
        start_time: availability.start_time,
        end_time: availability.end_time,
        availability_id: availability.id,
        doctor_id: availability.doctor.id,
        patient_id: patient.id
      )
    end

    let!(:availability_2) do
      Availability.create(
        start_time: Time.current,
        end_time: Time.current + 2.hours,
        booked: false,
        doctor: doctor,
        working_hours_id: working_hours.id
      )
    end

    context 'with valid attributes' do
      it 'updates the appointment and returns a json response with ok' do
        patch :update, params: { id: appointment.id, doctor_id: doctor.id, availability_id: availability_2.id }
        appointment.reload
        expect(appointment.start_time.hour).to eq(availability_2.start_time.hour)
        expect(response).to have_http_status(:ok)
      end

      it 'updates the availability as unbooked' do
        patch :update, params: { id: appointment.id, doctor_id: doctor.id, appointment: { start_time: Time.current } }
        availability.reload
        expect(availability.booked).to be(false)
      end
    end

    context 'with invalid attributes' do
      it 'raise a JSON response with status :not_found' do
        patch :update, params: { id: appointment.id, doctor_id: doctor.id, appointment: { start_time: nil } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:appointment) do
      Appointment.create(
        start_time: availability.start_time,
        end_time: availability.end_time,
        availability_id: availability.id,
        doctor_id: availability.doctor.id,
        patient_id: patient.id
      )
    end

    it 'destroys the appointment' do
      expect(Appointment.count).to be(1)
      delete :destroy, params: { doctor_id: doctor.id, id: appointment.id }
      expect(Appointment.count).to be(0)
    end

    it 'updates the availability as unbooked' do
      delete :destroy, params: { doctor_id: doctor.id, id: appointment.id }
      availability.reload
      expect(availability.booked).to be(false)
    end

    it 'returns a JSON response with status :ok' do
      delete :destroy, params: { doctor_id: doctor.id, id: appointment.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
