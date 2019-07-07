Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      post 'subscribe', to: 'authentication#subscribe'
      resources :images, only: [:index, :create]
    end
  end
end
