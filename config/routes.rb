Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#hello'
  root 'static_pages#home'
  get  'static_pages/home'
  get  'static_pages/about'
  get  'static_pages/help'
 
end




# static_pages/home
# このルールは↑のURLに対するリクエストをStaticPagesコントローラのhomeアクションと結びつけています。
# 今回はgetと書かれているため、GETリクエストを受け取った時に対応するアクションを結びつけています。
