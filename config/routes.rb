ItemCheckoutx::Engine.routes.draw do
  
  resources :checkouts do
      
      collection do
        get :search
        get :search_results
        get :stats
        get :stats_results  
        get :list_items
      end
            
  end
  
  root :to => 'checkouts#index'

end
