Rails.application.routes.draw do

  mount ItemCheckoutx::Engine => "/item_checkoutx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount Supplierx::Engine => '/supplierx'
  mount Kustomerx::Engine => '/kustomerx'
  mount ExtConstructionProjectx::Engine => '/project'
  mount Searchx::Engine => '/searchx'
  mount PettyWarehousex::Engine => '/pwhs'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
