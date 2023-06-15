Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
    get 'users/show'
    get 'users/edit'
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
  
  root to: 'homes#top'
  get "search" => "searches#search"
  
#会員側ルーティング
  scope module: :public do
    get 'posts/my_page' => 'posts#my_page', as: 'my_page'
    get 'users/quit' => 'users#quit', as: 'confirm_quit'
    patch 'users/out' => 'users#out', as: 'out_user'
    resources :posts, only: [:new, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      resources :posts, only: [:index]
      member do
        get :favorites
      end
    end
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end

  
  #管理者側ルーティング
  namespace :admin do
    get '/' => 'homes#top'
    resources :posts, only: [:destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :users, only: [:edit,:update, :index] do
      resources :posts, only: [:index]
    end
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  

end
