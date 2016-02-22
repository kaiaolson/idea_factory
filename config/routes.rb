Rails.application.routes.draw do
  resources :ideas do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy, :show]
    resources :memberships, only: [:create, :destroy]
  end
  resources :users, except: [:index, :destroy]
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  root "ideas#index"
end
