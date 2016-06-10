require_dependency "item_checkoutx/application_controller"

module ItemCheckoutx
  class CheckoutsController < ApplicationController
    before_action :require_employee
    before_action :load_parent_record
    after_action :info_logger, :except => [:new, :edit, :event_action_result, :wf_edit_result, :search_results, :stats_results, :acct_summary_result]
    
    def index
      @title = t('Checkout Items')
      @checkouts = params[:item_checkoutx_checkouts][:model_ar_r]
      @checkouts = @checkouts.where(:whs_string => @whs_string) if @whs_string
      @checkouts = @checkouts.where(:item_id => @item.id) if @item
      @checkouts = @checkouts.where(:wf_state => params[:wf_state]) if params[:wf_state]
      @checkouts = @checkouts.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('checkout_index_view', session[:fort_token], 'item_checkoutx')
    end
  
    def new
      @title = t('New Checkout Item')
      @checkout = ItemCheckoutx::Checkout.new()
      #@qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('checkout_new_view', session[:fort_token], 'item_checkoutx')
    end
  
    def create
      @checkout = ItemCheckoutx::Checkout.new(new_params)
      @checkout.last_updated_by_id = session[:user_id]
      @checkout.requested_by_id = session[:user_id]
      @checkout.checkout_by_id = session[:user_id]
      @checkout.fort_token = session[:fort_token]
      @checkout.transaction do  #need to deduct the qty of checkout from the item.stock_qty
        stock_enough = (@item.stock_qty >= params[:checkout][:requested_qty].to_i)
        @item.stock_qty -= params[:checkout][:out_qty].to_i if params[:checkout][:out_qty].present?
        if stock_enough && @checkout.save && @item.save 
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
        else
          #@qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
          @item = ItemCheckoutx.item_class.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?
          @erb_code = find_config_const('checkout_new_view', session[:fort_token], 'item_checkoutx')
          flash[:notice] = t('Data Error. Not Saved!')
          render 'new'  
        end
      end 
    end
  
    def edit
      @title = t('Update Checkout Item')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      #@qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('checkout_edit_view', session[:fort_token], 'item_checkoutx')

    end
  
    def update
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      
      stock_enough = (@item.stock_qty >= params[:checkout][:requested_qty].to_i)
      if stock_enough && @checkout.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        #@qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        @erb_code = find_config_const('checkout_edit_view', session[:fort_token], 'item_checkoutx')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'   
      end
    end
    
    def show
      @title = t('Checkout Item Info')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_show_view', session[:fort_token], 'item_checkoutx')
    end
    
    def list_items
      index
    end

    protected
    def load_parent_record
      @item = ItemCheckoutx.item_class.find_by_id(params[:item_id]) if params[:item_id].present?
      @item = ItemCheckoutx.item_class.find_by_id(ItemCheckoutx::Checkout.find_by_id(params[:id]).item_id) if params[:id].present?
      @item = ItemCheckoutx.item_class.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?      
      @whs_string = params[:whs_string].strip if params[:whs_string].present?
      @qty_unit = find_config_const('piece_unit', session[:fort_token]).split(',').map(&:strip) if find_config_const('piece_unit', session[:fort_token])
      @qty_unit = return_misc_definitions('piece_unit') unless find_config_const('piece_unit', session[:fort_token])
    end
    
    private
    
    def new_params
      params.require(:checkout).permit(:brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :requested_by_id, :requested_qty, :wf_state,  
                     :request_date, :unit, :skip_wf, :whs_string, :aux_resource)
    end
    
    def edit_params
      params.require(:checkout).permit(:brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :requested_by_id, :requested_qty, :wf_state, 
                     :request_date, :unit, :released, :skip_wf)
    end
  end
end
