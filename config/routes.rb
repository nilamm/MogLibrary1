Rails.application.routes.draw do
 get '/catalog' => 'catalog#index', as: :excel
 get '/search' => 'catalog#search', as: :resources
 get '/edit/:id' => 'catalog#edit', as: :edit
 patch '/:id' => 'catalog#update'
 get '/new' => 'catalog#new', as: :new
 post '/catalog' => 'catalog#create'
 root 'catalog#welcome'

 get 'signup' => 'users#new'
 resources :users

 get '/login' => 'sessions#new'
 post 'login' => 'sessions#create'
 delete 'logout' => 'sessions#destroy'

 get '/admin' => 'backend#index', as: :backend
 
end
