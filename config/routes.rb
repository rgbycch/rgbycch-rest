require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1 do
      resources :users, :only             => [:show, :create, :update, :destroy]
      resources :clubs, :only             => [:show, :create, :update, :destroy]
      resources :teams, :only             => [:show, :create, :update, :destroy]
      resources :event_types, :only       => [:show, :create, :update, :destroy]
      resources :score_types, :only       => [:show, :create, :update, :destroy]
      resources :player_positions, :only  => [:show, :create, :update, :destroy]
      resources :roles, :only             => [:show, :create, :update, :destroy]
      resources :players, :only           => [:show, :create, :update, :destroy]
      resources :sessions, :only          => [:create, :destroy]
    end
  end
end
