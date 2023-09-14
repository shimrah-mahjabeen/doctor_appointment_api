module Authorizable
  extend ActiveSupport::Concern

  def authorize_patient
    raise StandardError, I18n.t('errors.authorization') if current_user.id != @appointment.patient.id
  end
end
