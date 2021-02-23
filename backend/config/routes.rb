Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :importer, only: [:index, :create] do
      end
    end
  end
end
