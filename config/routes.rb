Rails.application.routes.draw do
  devise_for :users
  root 'root_pages#home'

  namespace :api do
    namespace :v1 do
      resources :surveys
    end
  end
end
