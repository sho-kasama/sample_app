Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#hello'
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help', as: 'helf'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]  
end




# static_pages/home
# このルールは↑のURLに対するリクエストをStaticPagesコントローラのhomeアクションと結びつけています。
# 今回はgetと書かれているため、GETリクエストを受け取った時に対応するアクションを結びつけています。

# as を使うことで名前付きルートの名前を変更することができる