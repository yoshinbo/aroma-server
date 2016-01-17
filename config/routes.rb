Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :users, only: [:create, :show]
        ## NOTE : - user_idをパラメータに持ちたくないので自分の情報の取得、更新用にme_controllerを用意
        #get 'me' => 'me#show'
        #put 'me' => 'me#update'
        #put 'me/setting/:key/:value' => 'me#update_setting'
        #
        #resources :recipes, except: [:new]
        #resources :regions, only: [:index]
        #resources :categories, only: [:index]
      end
    end
  end
end
