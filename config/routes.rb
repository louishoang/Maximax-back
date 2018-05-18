Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, controllers: {
          registrations: 'api/v1/users/registrations',
          sessions: 'api/v1/users/sessions'
      }
    end
  end
end
