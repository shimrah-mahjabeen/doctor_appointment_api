module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!
    end
  end
end
