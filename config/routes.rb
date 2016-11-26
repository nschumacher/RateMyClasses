Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :courses do
    resources :reviews, except: [:show, :index]
    collection do
      get 'search'
      put :update_lastedited
    end
    member do
      put :update_lastedited
    end
  end
  
  resources :departments do
    collection do
      get 'search'
    end
  end

  resources :reviews do
      member do
        put "like", to: "reviews#upvote"
        put "dislike", to: "reviews#downvote"
        put "funny", to: "reviews#funnyvote"
        put "flag", to: "reviews#flag"
        put "unflag", to: "reviews#unflag"
      end
  end

  resources :answers do
      member do
        put "like", to: "answers#upvote"
        put "dislike", to: "answers#downvote"
        put "flag", to: "answers#flag"
        put "unflag", to: "answers#unflag"
      end
  end

  get 'pages/home'

  get 'pages/contact'

  get 'pages/privacypolicy'

  get 'pages/results'

  get 'pages/admin'

  #get 'pages/Course_Profile/:id' => 'pages#Course_Profile' , :id => 'id'
  get  'courses/show/:id' => 'courses#show', :id => 'id'

  root 'pages#home'

  post '/rate' => 'rater#create', :as => 'rate'
  get 'pages/about'
  get 'ContactUs', to: 'messages#new', as: 'contact'
  post 'ContactUs', to: 'messages#create'
  devise_for :users

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
