Rails.application.routes.draw do
  root 'screaming_frogs#new'
  resources :screaming_frogs, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
