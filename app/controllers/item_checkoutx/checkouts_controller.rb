require_dependency "item_checkoutx/application_controller"

module ItemCheckoutx
  class CheckoutsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
    
    def index
      @title = t('Checkout Items')
      @checkouts = params[:item_checkoutx_checkouts][:model_ar_r]
      @checkouts = @checkouts.where(:whs_string => @whs_string) if @whs_string
      @checkouts = @checkouts.where(:item_id => @item.id) if @item
      @checkouts = @checkouts.where(:wf_state => params[:wf_state]) if params[:wf_state]
      @checkouts = @checkouts.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('checkout_index_view', 'item_checkoutx')
    end
  
    def new
      @title = t('New Checkout Item')
      @checkout = ItemCheckoutx::Checkout.new()
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('checkout_new_view', 'item_checkoutx')
    end
  
    def create
      @checkout = ItemCheckoutx::Checkout.new(params[:checkout], :as => :role_new)
      @checkout.last_updated_by_id = session[:user_id]
      @checkout.requested_by_id = session[:user_id]
      @checkout.checkout_by_id = session[:user_id]
      @item = ItemCheckoutx.item_class.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?
      @checkout.transaction do  #need to deduct the qty of checkout from the item.stock_qty
        stock_enough = (@item.stock_qty >= params[:checkout][:requested_qty].to_i)
        @item.stock_qty -= params[:checkout][:out_qty].to_i if params[:checkout][:out_qty].present?
        if @checkout.save && @item.save && stock_enough
          redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
        else
          @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
          @erb_code = find_config_const('checkout_new_view', 'item_checkoutx')
          flash[:notice] = t('Data Error. Not Saved!')
          render 'new'
        end
      end 
    end
  
    def edit
      @title = t('Update Checkout Item')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('checkout_edit_view', 'item_checkoutx')
      if !@checkout.skip_wf && @checkout.wf_state.present? && @checkout.current_state != :initial_state
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=NO Update. Record Being Processed!")
      end

    end
  
    def update
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      if !(!@checkout.skip_wf && @checkout.wf_state.present? && @checkout.current_state != :initial_state)
        stock_enough = (@item.stock_qty >= params[:checkout][:requested_qty].to_i)
        if stock_enough && @checkout.update_attributes(params[:checkout], :as => :role_update)
          redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
        else
          @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
          @erb_code = find_config_const('checkout_edit_view', 'item_checkoutx')
          flash[:notice] = t('Data Error. Not Updated!')
          render 'edit'
        end
      end
    end
    
    def show
      @title = t('Checkout Item Info')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_show_view', 'item_checkoutx')
    end

    def list_open_process  
      index()
      @checkouts = return_open_process(@checkouts, find_config_const('checkout_wf_final_state_string', 'item_checkoutx'))  # ModelName_wf_final_state_string
    end
    
    def list_items
      index
    end

    protected
    def load_parent_record
      @item = ItemCheckoutx.item_class.find_by_id(params[:item_id]) if params[:item_id].present?
      @item = ItemCheckoutx.item_class.find_by_id(ItemCheckoutx::Checkout.find_by_id(params[:id]).item_id) if params[:id].present?
      @project_id = params[:project_id].to_i if params[:project_id].present?
      @whs_string = params[:whs_string].strip if params[:whs_string].present?
    end
  end
end
