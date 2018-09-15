Rails.application.routes.draw do
  get 'article_category/new'
  get 'article_category/create'
  devise_for :users
  root 'static_pages#index'
  get 'articles/new'
  get 'articles/create'
  
  resources :categories, except: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
