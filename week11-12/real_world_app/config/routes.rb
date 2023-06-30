Rails.application.routes.draw do
  get '/health_check', to: proc { [200, {}, ['']] }
  scope :api do
    resources :articles, param: :slug, except: %i[index]
  end
end
