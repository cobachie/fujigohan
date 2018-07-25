Rails.application.routes.draw do

  resources :stands, only: [:index] do
    member do
      get :add_fav
      get :remove_fav
    end
  end

  root to: "stands#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
