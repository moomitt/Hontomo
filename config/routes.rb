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
    resources :users, only: [:index, :show, :edit, :update, :comment]
    resources :books, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:destroy]
  end
  
  scope module: 'public' do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    
    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'user/confirm'
    patch 'user/withdraw'
    
    resources :books, only: [:index, :new, :create, :show, :edit, :update] do
      resources :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:new, :create]
    end
    get 'books/search'
    
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
