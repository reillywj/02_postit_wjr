PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # resources :posts, except: [:destroy] do
  #   resources :comments, only: [:create, :show]
  # end
  resources :posts, except: [:destroy] do
    resources :comments, except: [:destroy]
  end
end
