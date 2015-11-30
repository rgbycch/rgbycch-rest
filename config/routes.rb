require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1 do
      resources :users, :only               => [:show, :create, :update, :destroy]
      resources :clubs, :only               => [:show, :create, :update, :destroy, :index]
      resources :teams, only: [:show, :create, :update, :destroy, :index] do
        put 'add_player'
        put 'remove_player'
      end
      resources :event_types, :only         => [:show, :create, :update, :destroy, :index]
      resources :score_types, :only         => [:show, :create, :update, :destroy, :index]
      resources :player_positions, :only    => [:show, :create, :update, :destroy, :index]
      resources :preferred_positions, :only => [:show, :create, :update, :destroy]
      resources :roles, :only               => [:show, :create, :update, :destroy, :index]
      resources :players, :only             => [:show, :create, :update, :destroy, :index]
      resources :match_states, :only        => [:show, :create, :update, :destroy, :index]
      resources :officials, :only           => [:show, :create, :update, :destroy, :index]
      resources :venues, :only              => [:show, :create, :update, :destroy, :index]
      resources :match_day_teams, :only     => [:show, :create, :update, :destroy, :index]
      resources :sessions, :only            => [:create, :destroy]
    end
  end
end
