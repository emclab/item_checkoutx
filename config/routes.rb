ItemCheckoutx::Engine.routes.draw do
  
  resources :checkouts do
    
    workflow_routes = Authentify::AuthentifyUtility.find_config_const('checkout_wf_route', 'item_checkoutx')
    if Authentify::AuthentifyUtility.find_config_const('wf_route_in_config') == 'true' && workflow_routes.present?
      eval(workflow_routes) 
    elsif Rails.env.test?
      member do
        get :event_action
        patch :submit
        patch :approve
        patch :reject
        patch :release
        patch :rewind
      end
      
      collection do
        get :list_items
        get :list_open_process
      end
      
      
    end
  end
  
  root :to => 'checkouts#index'

end
