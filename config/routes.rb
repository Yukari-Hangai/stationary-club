Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'user/show'
    get 'user/edit'
  end
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
  
  resources :posts, only: [:new, :create, :index, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
      resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
end

#管理者側ルーティング
namespace :admin do
  
end
  

end
