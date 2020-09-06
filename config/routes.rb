Rails.application.routes.draw do
  devise_for :users
  root 'root_pages#home'
end
