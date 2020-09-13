Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root "root_pages#manage_surveys", as: :authenticated_root
  end

  root 'root_pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :surveys
      resources :applications, only: [:create, :show]
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
  end
end
