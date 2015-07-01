Rails.application.routes.draw do
 get '/catalog' => 'catalog#index'
 get '/search' => 'catalog#search', as: :resources
 get '/edit/:id' => 'catalog#edit', as: :edit
 patch '/:id' => 'catalog#update'
 get '/new' => 'catalog#new', as: :new
 post '/catalog' => 'catalog#create'
 root 'catalog#welcome'
end
