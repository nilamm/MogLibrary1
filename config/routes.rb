Rails.application.routes.draw do
 get '/catalog' => 'catalog#index', as: :excel
 get '/catalog/:id' => 'catalog#show', as: :show_resource
 get '/search' => 'catalog#search', as: :resources
 get '/edit/:id' => 'catalog#edit', as: :edit
 patch '/:id' => 'catalog#update'
 get '/new' => 'catalog#new', as: :new
 post '/catalog' => 'catalog#create'
 root 'catalog#welcome'

 delete '/catalog/:id' => 'catalog#destroy', as: :delete_resource

 get 'signup' => 'users#new'
 resources :users

 get '/login' => 'sessions#new'
 post 'login' => 'sessions#create'
 delete 'logout' => 'sessions#destroy'

 get '/admin' => 'backend#index', as: :backend

 resources :checkouts
 get '/usercheckouts' => 'users#user_checkouts', as: :user_checkouts
 get '/catalog/:id/return' => 'checkouts#return', as: :return
 patch '/catalog/:id/return' => 'checkouts#return_update'
 get '/catalog/:id/checkouts' => 'catalog#show_checkouts', as: :resource_checkouts

 resources :comments
 resources :favorites
 delete 'favorites/' => 'favorites#destroy_by_params', as: :destroy_favorites_params
 
end
