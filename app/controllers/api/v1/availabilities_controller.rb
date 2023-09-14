module Api
  module V1
    class AvailabilitiesController < ApiController
      before_action :set_doctor

      def index
        @availabilities = @doctor.availabilities
        render json: @availabilities
      end

      def open_slots
        @availabilities = @doctor.availabilities.where(booked: false)
        render json: @availabilities
      end

      private

      def set_doctor
        @doctor = Doctor.find(params[:doctor_id])
      end
    end
  end
end
