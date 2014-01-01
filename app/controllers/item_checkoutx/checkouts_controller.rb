require_dependency "item_checkoutx/application_controller"

module ItemCheckoutx
  class CheckoutsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
    
    def index
      @title = t('Warehouse Items')
      @checkouts = params[:item_checkoutx_checkouts][:model_ar_r]
      @checkouts = @checkouts.where(:item_id => @item.id) if @item
      @checkouts = @checkouts.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('checkout_index_view', 'item_checkoutx_checkouts')
    end
  
    def new
      @title = t('New Warehouse Item')
      @checkout = ItemCheckoutx::Checkout.new()
      @erb_code = find_config_const('checkout_new_view', 'item_checkoutx_checkouts')
    end
  
    def create
      @checkout = ItemCheckoutx::Checkout.new(params[:checkout], :as => :role_new)
      @checkout.last_updated_by_id = session[:user_id]
      @checkout.requested_by_id = session[:user_id]
      @checkout.transaction do  #need to deduct the qty of checkout from the item.stock_qty
        @item.stock_qty -= params[:checkout][:out_qty].to_i
        if @checkout.save && @item.save && @item.stock_qty >= 0
          redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
        else
          @item = ItemCheckoutx.item_class.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?
          flash[:notice] = t('Data Error. Not Saved!')
          render 'new'
        end
      end 
    end
  
    def edit
      @title = t('Update Warehouse Item')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_edit_view', 'item_checkoutx_checkouts')
    end
  
    def update
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @checkout.last_updated_by_id = session[:user_id]
      if @checkout.update_attributes(params[:checkout], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end

=begin  
    def show
      @title = t('Warehouse Item Info')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_show_view', 'item_checkoutx_checkouts')
    end
=end
    protected
    def load_parent_record
      @item = ItemCheckoutx.item_class.find_by_id(params[:item_id]) if params[:item_id].present?
      @item = ItemCheckoutx.item_class.find_by_id(ItemCheckoutx::Checkout.find_by_id(params[:id]).item_id) if params[:id].present?
    end
  end
end
