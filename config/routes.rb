require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1 do

    end
  end
end
