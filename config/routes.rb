Rails.application.routes.draw do
  resources :screaming_frogs, only: [:new, :create]
  resources :safe_redirect_managers, only: [:new, :create]
end
