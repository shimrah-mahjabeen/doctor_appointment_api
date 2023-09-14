module Api
  module V1
    class WorkingHoursController < ApiController
      before_action :set_doctor

      def index
        @working_hours = @doctor.working_hours
        render json: @working_hours
      end

      private

      def set_doctor
        @doctor = Doctor.find(params[:doctor_id])
      end
    end
  end
end
