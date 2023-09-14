module Api
  module V1
    class AppointmentsController < ApiController
      include Authorizable

      before_action :set_appointment, :authorize_patient, only: %i[update destroy]
      before_action :set_availability, only: %i[create update]

      def create
        appointment = Appointment.new(
          start_time: @availability.start_time,
          end_time: @availability.end_time,
          patient_id: current_user.id,
          doctor_id: @availability.doctor.id,
          availability_id: @availability.id
        )

        if appointment.save
          @availability.update(booked: true)
          render json: appointment, status: :created
        else
          render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @appointment&.availability.update(booked: false)
        if @appointment.update(availability_id: @availability.id)
          render json: @appointment, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @appointment.destroy
          @appointment&.availability.update(booked: false)
          render json: { message: I18n.t('appointments.deletion') }, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      def set_availability
        @availability = Availability.find(params[:availability_id])
      end
    end
  end
end
