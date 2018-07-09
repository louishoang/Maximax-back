# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }

      namespace :admin do
        resources :products
        resources :product_images
        resources :option_types
        resources :variants
        resources :properties
        resources :categories, only: :index
        resources :brands, only: %i[index create update]
        resources :product_properties do
          collection do
            post :update_from_product
          end
        end
      end

      resources :home, only: :index do
        collection do
          get :new_arrivals
        end
      end
    end
  end
end
