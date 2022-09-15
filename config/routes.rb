Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    get 'users/:id/comment' => 'users#comment', as: 'user_comment'
    get 'books/search'
    resources :books, only: [:index, :show, :edit, :update, :destroy]
    get 'comments/search'
    resources :comments, only: [:destroy]
    get 'comments/search'
    resources :comments, only: [:destroy]
    resources :tags, only: [:index, :destroy]
  end
  
  scope module: 'public' do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    
    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm'
    patch 'users/withdraw'
    
    get 'books/find'
    get 'books/search'
    resources :books, only: [:index, :new, :create, :show, :edit, :update] do
      resources :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:new, :create] do
        resource :goods, only: [:create, :destroy]    #URLにgoodのidを含む必要がないため、resourceで記述
      end
      member do
        get :search_comment
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
