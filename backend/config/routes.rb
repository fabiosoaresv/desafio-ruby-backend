Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :importer, only: [:index] do
        collection { post :import_file, via: :options }
      end
      resources :transactions, only: [:index]
    end
  end
end
