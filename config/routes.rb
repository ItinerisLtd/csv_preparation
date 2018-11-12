Rails.application.routes.draw do
  resources :kinsta_escapes, only: [:new, :create]
  resources :screaming_frogs, only: [:new, :create]
  resources :safe_redirect_managers, only: [:new, :create]
end
