Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      resources :images
    end
  end
end
