Rails.application.routes.draw do
  resources :vehicle_types do
    collection do
      post :import
    end
  end

  resources :fuels do
    collection do
      post :import
    end
  end

  devise_for :users
  root to: 'welcome#home'
end
