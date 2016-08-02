Rails.application.routes.draw do
  root 'sandboxes#new'

  resources :posts
end
