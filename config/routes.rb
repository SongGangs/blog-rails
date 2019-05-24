Rails.application.routes.draw do
  get 'flights/search'
  resources :flight_prices
  resources :flights do
    # resources :flight_prices
  end
  resources :users
  get 'welcome/index'
  get 'articles/new'
  get 'articles/download'
  get 'articles/preview'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments
  end
  root 'welcome#index'
end