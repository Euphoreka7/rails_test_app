Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :experiments, only: :index
    end
  end

  get '/', to: 'statistics#show'
end
