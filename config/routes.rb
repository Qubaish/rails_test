Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users

  resources :projects do
      resources :bugs
  end

  resources :bugs, only: [:index]

  match "/change_status" => "bugs#change_status", via: [:post]
  match "/bug_status" => "bugs#bug_status", via: [:post]
  root 'users#index'

end
