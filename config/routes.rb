Rails.application.routes.draw do
  root 'screaming_frogs#new'

  resources :screaming_frogs, only: [:new, :create]
  resources :safe_redirect_managers, only: [:new, :create]
end
