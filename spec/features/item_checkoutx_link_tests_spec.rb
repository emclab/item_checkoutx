require 'spec_helper'

describe "LinkTests" do
  describe "GET /checkoutx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
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

      final_state = 'rejected, checkedout'
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_action_def', :argument_value => wf)
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_final_state_string', :argument_value => final_state)
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_pdef_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_route_in_config', :argument_value => nil)
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_validate_in_config', :argument_value => 'true')
      
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "ItemCheckoutx::Checkout.order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "record.requested_by_id == session[:user_id]")

      FactoryGirl.create(:user_access, :action => 'submit', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                               :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'approve', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'reject', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'rewind', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")

      FactoryGirl.create(:user_access, :action => 'checkout', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'event_action', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")

      FactoryGirl.create(:user_access, :action => 'list_items', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'list_submitted_items', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'list_approved_items', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'list_rejected_items', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'list_checkedout_items', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")

      @i = FactoryGirl.create(:petty_warehousex_item, :in_qty => 100, :stock_qty => 100)
      @i1 = FactoryGirl.create(:petty_warehousex_item, :in_qty => 100, :name => 'a new name', :stock_qty => 100)

      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id)
      visit checkouts_path
      #save_and_open_page
      page.should have_content('Warehouse Checkouts')
      click_link 'Edit'
      page.should have_content('Edit Warehouse Checkout')
      fill_in 'checkout_out_qty', :with => 40
      click_button 'Save'
      save_and_open_page

      # submit for manager review
      visit checkouts_path
      save_and_open_page
      click_link 'Submit Checkout'
      save_and_open_page

      #bad data
      visit checkouts_path
      click_link 'Edit'
      fill_in 'checkout_out_date', :with => nil
      click_button 'Save'
      save_and_open_page

      visit new_checkout_path(:item_id => @i1.id)
      #save_and_open_page
      page.should have_content('New Warehouse Checkout')
      fill_in 'checkout_out_qty', :with => 40
      fill_in 'checkout_out_date', :with => Date.today
      fill_in 'checkout_requested_qty', :with => 40
      click_button 'Save'
      save_and_open_page
      #bad data
      visit new_checkout_path(:item_id => @i1.id)
      fill_in 'checkout_out_qty', :with => 40
      fill_in 'checkout_out_date', :with => Date.today
      fill_in 'checkout_requested_qty', :with => 0
      click_button 'Save'
      save_and_open_page
    end

    it "should checkout an approved item" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'approved')
      visit checkouts_path  #allow to redirect after save new below
      page.should have_content('Approved')
      page.should have_content('Warehouse Checkouts')
      click_link 'Checkout'
      save_and_open_page
      click_button 'Save'
      visit checkouts_path()
      save_and_open_page
      page.should have_content('Checkedout')
    end
    
    it "checkout from submit request to final checkout" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'initial_state')
      visit checkouts_path
      page.should have_content('Submit Checkout')
      click_link 'Submit Checkout'
      fill_in 'checkout_wf_comment', :with => 'Submitting checkout'
      click_button 'Save'
      visit checkouts_path
      save_and_open_page

      page.should have_content('Reviewing')
      click_link 'Approve'
      fill_in 'checkout_wf_comment', :with => 'Approving checkout'
      click_button 'Save'
      visit checkouts_path
      save_and_open_page

      page.should have_content('Approved')
      click_link 'Checkout'
      fill_in 'checkout_wf_comment', :with => 'Checking checkout'
      click_button 'Save'
      visit checkouts_path
      save_and_open_page
      page.should have_content('Checkedout')
    end

    it "rewind after rejecting a submited checkout request" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'initial_state')
      visit checkouts_path
      page.should have_content('Submit Checkout')
      click_link 'Submit Checkout'
      fill_in 'checkout_wf_comment', :with => 'Submitting checkout'
      click_button 'Save'
      visit checkouts_path
      save_and_open_page

      page.should have_content('Reviewing')
      click_link 'Reject'
      fill_in 'checkout_wf_comment', :with => 'Rejecting checkout'
      click_button 'Save'
      visit checkouts_path
      save_and_open_page

      page.should have_content('Rejected')
      click_link 'Rewind'
      fill_in 'checkout_wf_comment', :with => 'Rewinding. Please re-submit request'
      save_and_open_page
      click_button 'Save'
      visit checkouts_path
      save_and_open_page
      page.should have_content('Initial State')
    end

    it "list submitted request then reviewing requests, then rejected requests" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'initial_state')
      visit list_items_checkouts_path(:wf_state => 'initial_state')
      page.should have_content('Submit Checkout')
      click_link 'Submit Checkout'
      fill_in 'checkout_wf_comment', :with => 'Submitting checkout'
      click_button 'Save'

      visit list_items_checkouts_path(:wf_state => 'reviewing')
      save_and_open_page
      page.should have_content('Reviewing')

      click_link 'Reject'
      fill_in 'checkout_wf_comment', :with => 'Rejecting checkout'
      click_button 'Save'
      visit list_items_checkouts_path(:wf_state => 'rejected')
      page.should have_content('Rejected')
    end

  end
end
