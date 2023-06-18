Rails.application.routes.draw do
  get 'articles/get'
  scope :api do
    resources :articles, param: :slug, except: %i[index]
  end
end
