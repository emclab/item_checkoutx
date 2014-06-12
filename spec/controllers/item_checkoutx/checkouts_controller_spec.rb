require 'spec_helper'

module ItemCheckoutx
  describe CheckoutsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      
    end
    
    before(:each) do
      wf = "def submit
          wf_common_action('initial_state', 'manager_reviewing', 'submit')
        end   
        def manager_approve
          wf_common_action('manager_reviewing', 'manager_approve')
        end 
        def store_manager_reject
          wf_common_action('manager_reviewing', 'initial_state', 'manager_reject')
        end
        def manager_rewind
          wf_common_action('manager_reviewing', 'initial_state', 'manager_rewind')
        end
        def checkout
          wf_common_action('approved', 'checkout', 'checkedout')
        end"
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_action_def', :argument_value => wf)
      final_state = 'rejected, checkedout'
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_final_state_string', :argument_value => final_state)
      
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_pdef_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_route_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_validate_in_config', :argument_value => 'true')


      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      @q_task = FactoryGirl.create(:init_event_taskx_event_task)
      @q_task1 = FactoryGirl.create(:init_event_taskx_event_task, :name => 'a new name')
      @supplier = FactoryGirl.create(:supplierx_supplier)
      @q = FactoryGirl.create(:in_quotex_quote, :task_id => @q_task.id, :supplier_id => @supplier.id)
      @q1 = FactoryGirl.create(:in_quotex_quote, :task_id => @q_task1.id, :supplier_id => @supplier.id)
      @o = FactoryGirl.create(:purchase_orderx_order, :quote_id => @q.id)
      @o1 = FactoryGirl.create(:purchase_orderx_order, :quote_id => @q1.id)
      @i = FactoryGirl.create(:jobshop_warehousex_item, :purchase_order_id => @o.id)
      @i1 = FactoryGirl.create(:jobshop_warehousex_item, :purchase_order_id => @o1.id)
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all quotes" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.scoped.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        get 'index', {:use_route => :item_checkoutx}
        assigns(:checkouts).should =~ [q, q1]
      end

      it "returns rejected quotes" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.scoped.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        
        get 'index', {:use_route => :item_checkoutx}
        assigns(:checkouts).should =~ [q, q1]
      end


    describe "GET 'list open process" do
      it "return open process only" do
        user_access = FactoryGirl.create(:user_access, :action => 'list_open_process', :resource =>'exp_reinbersex_reinberses', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ExpReinbersex::Reinberse.where(:void => false).order('created_at DESC')")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:exp_reinbersex_reinberse, :created_at => 50.days.ago, :wf_state => 'initial_state')  #created too long ago to show
        q1 = FactoryGirl.create(:exp_reinbersex_reinberse, :wf_state => 'ceo_reviewing')
        q2 = FactoryGirl.create(:exp_reinbersex_reinberse, :wf_state => 'initial_state')
        q3 = FactoryGirl.create(:exp_reinbersex_reinberse, :wf_state => 'rejected')  #wf_state can't be what was defined.
        get 'list_open_process', {:use_route => :exp_reinbersex}
        assigns(:reinberses).should =~ [q1, q2]
      end
    end




      
      it "should only return the quotes which belongs to the quote task" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ItemCheckoutx::Checkout.scoped.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id)
        get 'index', {:use_route => :item_checkoutx, :item_id => @i1.id}
        assigns(:checkouts).should =~ [q1]
      end
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :item_checkoutx, :item_id => @i.id}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:item_checkoutx_checkout, :item_id => @i1.id)
        get 'create', {:use_route => :item_checkoutx, :item_id => @i1.id, :checkout => q}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:item_checkoutx_checkout, :item_id => @i1.id, :out_qty => nil)
        get 'create', {:use_route => :item_checkoutx, :item_id => @i1.id, :checkout => q}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'edit', {:use_route => :item_checkoutx, :id => q.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', {:use_route => :item_checkoutx, :id => q.id, :checkout => {:requested_qty => 20}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', {:use_route => :item_checkoutx, :id => q.id, :checkout => {:requested_qty => 0}}
        response.should render_template('edit')
      end
    end

=begin  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.checkout_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i1.id, :checkout_by_id => @u.id, :last_updated_by_id => @u.id)
        get 'show', {:use_route => :item_checkoutx, :id => q.id }
        response.should be_success
      end
    end
=end
  end
end
