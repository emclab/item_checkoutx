Rails.application.routes.draw do

  mount ItemCheckoutx::Engine => "/item_checkoutx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount InitEventTaskx::Engine => '/event_taskx'
  mount PurchaseOrderx::Engine => '/purchase_orderx'
  mount Supplierx::Engine => '/supplierx'
  mount InQuotex::Engine => '/in_quotex'
  mount JobshopWarehousex::Engine => '/warehousex'
  mount MfgOrderx::Engine => '/orderx'
  mount JobshopRfqx::Engine => '/rfqx'
  mount Kustomerx::Engine => '/kustomerx'
  mount JobshopQuotex::Engine => '/quotex'
  mount MfgProcessx::Engine => '/processx'
  mount EventTaskx::Engine => '/event_taskx'
  mount Searchx::Engine => '/searchx'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/wf'
  mount PettyWarehousex::Engine => '/pw'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
