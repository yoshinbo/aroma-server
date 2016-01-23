Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]

        #get 'me' => 'me#show'
        #put 'me' => 'me#update'
        #put 'me/setting/:key/:value' => 'me#update_setting'

        resources :recipes, except: [:index, :new]
        scope :recipe_timeline do
          get 'normal' => 'recipe_timeline#normal'
        end
        #resources :regions, only: [:index]
        #resources :categories, only: [:index]
      end
    end
  end
end
