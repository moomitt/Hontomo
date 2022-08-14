Rails.application.routes.draw do

  namespace :admin do
    get 'comments/destroy'
  end
  namespace :admin do
    get 'books/index'
    get 'books/show'
    get 'books/edit'
    get 'books/update'
    get 'books/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/comment'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'bookmarks/create'
    get 'bookmarks/destroy'
  end
  namespace :public do
    get 'comments/new'
    get 'comments/create'
  end
  namespace :public do
    get 'books/index'
    get 'books/new'
    get 'books/create'
    get 'books/show'
    get 'books/edit'
    get 'books/update'
    get 'books/search'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/confirm'
    get 'users/withdraw'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :users, skip: [:registrations, :passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
