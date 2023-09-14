Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :doctors, only: [] do
        resources :working_hours, only: %i[index]
        resources :appointments, only: %i[create update destroy]
        resources :availabilities, only: %i[index] do
          get :open_slots, on: :collection
        end
      end
    end
  end
end
