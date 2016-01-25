Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    resources :vehicle_types do
      collection do
        post :import
      end
    end

    resources :brands do
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
end
