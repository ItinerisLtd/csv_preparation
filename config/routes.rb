Rails.application.routes.draw do
  root 'preparations#new'
  resources :preparations, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
