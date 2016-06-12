require 'rails_helper'

module ItemCheckoutx
  RSpec.describe CheckoutsController, type: :controller do
    routes {ItemCheckoutx::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
      
    end
    
    before(:each) do
      wf = "def submit
          wf_common_action('initial_state', 'reviewing', 'submit')
        end   
        def approve
          wf_common_action('reviewing', 'approved', 'approve')
        end 
        def reject
          wf_common_action('reviewing', 'rejected', 'reject')
        end
        def rewind
          wf_common_action('rejected', 'initial_state', 'rewind')
        end
        def checkout
          wf_common_action('approved', 'checkedout', 'checkout')
        end"
      FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'enable_info_logger', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_action_def', :argument_value => wf)
      final_state = 'rejected, checkedout'
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_final_state_string', :argument_value => final_state)
      
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_pdef_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_route_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_validate_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => 'piece, set, kg')

      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      @i = FactoryGirl.create(:petty_warehousex_item, :in_qty => 100, :stock_qty => 100)
      @i1 = FactoryGirl.create(:petty_warehousex_item, :name => 'a new name', :in_qty => 100, :stock_qty => 100)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
      session[:fort_token] = @u.fort_token
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'rejected')
        q2 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        q3 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :wf_state => 'approved')
        get 'index'
        expect(assigns(:checkouts)).to match_array( [q, q1, q2, q3])
      end

      it "returns approved items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'approved')
        q2 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        
        get 'index', { :wf_state => 'approved'}
        expect(assigns(:checkouts)).to match_array( [q1])
      end

      it "returns rejected items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                                         :sql_code => "ItemCheckoutx::Checkout.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'rejected')
        q2 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)

        get 'index', { :wf_state => 'rejected'}
        expect(assigns(:checkouts)).to match_array( [q1])
      end

      it "returns checkedout items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'approved')
        q2 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        
        get 'index', { :wf_state => 'approved'}
        expect(assigns(:checkouts)).to match_array( [q1])
      end

      
      it "should only return the quotes which belongs to the quote task" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        get 'index', { :item_id => @i1.id}
        expect(assigns(:checkouts)).to match_array( [q1])
      end
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        get 'new', { :item_id => @i.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.attributes_for(:item_checkoutx_checkout, :item_id => @i1.id, :out_qty => 10, :requested_qty => 10)
        get 'create', { :item_id => @i1.id, :checkout => q}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
        expect(assigns(:checkout).out_qty).to eq(10)
        expect(assigns(:item).stock_qty).to eq(90)
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.attributes_for(:item_checkoutx_checkout, :item_id => @i1.id, :requested_qty => 0)
        get 'create', { :item_id => @i1.id, :checkout => q}
        expect(response).to render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'edit', { :id => q.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', { :id => q.id, :checkout => {:requested_qty => 20}}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', { :id => q.id, :checkout => {:requested_qty => 0}}
        expect(response).to render_template('edit')
      end
      
      it "should reject if requested_qyt is greater than stock_qty" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', { :id => q.id, :checkout => {:requested_qty => 120}}
        expect(response).to render_template('edit')
      end
    end
 
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.checkout_by_id == session[:user_id]")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :checkout_by_id => @u.id, :last_updated_by_id => @u.id)
        get 'show', { :id => q.id }
        expect(response).to be_success
      end
    end
    
    describe "GET 'destroy'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'destroy', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :checkout_by_id => @u.id, :last_updated_by_id => @u.id)
        get 'destroy', { :id => q.id }
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Deleted!")
      end
    end

  end
end
