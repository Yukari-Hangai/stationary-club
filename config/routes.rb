Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #↓skipで不要なルーティング削除
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#会員側ルーティング
root to: 'homes#top'

scope module: :public do
  get 'quit/:name' => 'homes#quit', as: 'confirm_quit'
  patch ':id/out/:name' => 'homes#out', as: 'out_user'
  
  resources :posts, only: [:new, :create, :index, :edit, :update, :destroy]
end

namespace :admin do
  
end
  

end
