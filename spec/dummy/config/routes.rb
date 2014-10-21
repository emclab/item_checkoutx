Rails.application.routes.draw do

  mount ItemCheckoutx::Engine => "/item_checkoutx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount Supplierx::Engine => '/supplierx'
  mount Kustomerx::Engine => '/kustomerx'
  mount ExtConstructionProjectx::Engine => '/project'
  mount Searchx::Engine => '/searchx'
  mount PettyWarehousex::Engine => '/pwhs'
  mount MaterialRequisitionx::Engine => 'material_requisition'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
