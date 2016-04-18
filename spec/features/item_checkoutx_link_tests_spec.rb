require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
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
         'mini-link'    => mini_btn +  'btn btn-link',
         'right-span#'         => '2', 
               'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4'
        }
    before(:each) do
      final_state = 'rejected, released'
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_wf_final_state_string', :argument_value => final_state)
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_pdef_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_route_in_config', :argument_value => nil)
      FactoryGirl.create(:engine_config, :engine_name => '', :engine_version => nil, :argument_name => 'wf_validate_in_config', :argument_value => 'true')
      FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => 'piece, set, kg')
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'checkout_release_inline', 
                         :argument_value => "<%= f.input :out_date, :as => :hidden, :input_html => {:value => Date.today} %>
                                             <%= f.input :requested_qty, :label => t('Request Qty'), :readonly => true, :input_html => {:value => @workflow_model_object.requested_qty} %>
                                             <%= f.input :out_qty, :label => t('Out Qty') %>
                                             <%= f.input :released, :as => :hidden, :input_html => {:value => true} %>
                                           ")
      FactoryGirl.create(:engine_config, :engine_name => 'item_checkoutx', :engine_version => nil, :argument_name => 'validate_checkout_release', 
                         :argument_value => "errors.add(:out_qty, I18n.t('Not be blank')) if out_qty.blank?
                                             errors.add(:out_qty, I18n.t('Release not more than requested')) if out_qty > requested_qty
                                           ")
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      config_entry = FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'SESSION_TIMEOUT_MINUTES', :argument_value => 30)
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

      FactoryGirl.create(:user_access, :action => 'release', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")
      FactoryGirl.create(:user_access, :action => 'event_action', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
                         :sql_code => "")

      FactoryGirl.create(:user_access, :action => 'list_open_process', :resource => 'item_checkoutx_checkouts', :role_definition_id => @role.id, :rank => 1,
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
      visit item_checkoutx.checkouts_path
      #save_and_open_page
      expect(page).to have_content('Checkout Items')
      click_link 'Edit'
      expect(page).to have_content('Update Checkout Item')
      fill_in 'checkout_requested_qty', :with => 40
      click_button 'Save'
      #save_and_open_page

      # submit for manager review
      #visit item_checkoutx.checkouts_path
      #save_and_open_page
      #click_link 'Submit Checkout'
      #save_and_open_page

      #bad data
      visit item_checkoutx.checkouts_path
      click_link 'Edit'
      fill_in 'checkout_requested_qty', :with => nil
      click_button 'Save'
      #save_and_open_page

      visit item_checkoutx.new_checkout_path(:item_id => @i1.id)
      #save_and_open_page
      expect(page).to have_content('New Checkout Item')
      fill_in 'checkout_requested_qty', :with => 40
      fill_in 'checkout_request_date', :with => Date.today
      select('piece', :from => 'checkout_unit')
      click_button 'Save'
      #save_and_open_page
      #bad data
      visit item_checkoutx.new_checkout_path(:item_id => @i1.id)
      fill_in 'checkout_requested_qty', :with => 0
      fill_in 'checkout_request_date', :with => Date.today
      select('piece', :from => 'checkout_unit')
      click_button 'Save'
      #save_and_open_page
    end
=begin
    it "should checkout an approved item" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :requested_qty => 10, :item_id => @i.id, :wf_state => 'approved')
      visit item_checkoutx.checkouts_path(:item_id => @i.id)  #allow to redirect after save new below
      expect(page).to have_content('Approved')
      expect(page).to have_content('Checkout Items')
      click_link 'Release'
      fill_in 'checkout_out_qty', :with => 10
      #save_and_open_page
      click_button 'Save'
      visit item_checkoutx.checkouts_path()
      #save_and_open_page
      expect(page).to have_content('Released')
      expect(@i.reload.stock_qty).to eq(90)
    end
    
    it "checkout from submit request to final checkout" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'initial_state')
      visit item_checkoutx.checkouts_path
      expect(page).to have_content('Submit Checkout')
      click_link 'Submit Checkout'
      fill_in 'checkout_wf_comment', :with => 'Submitting checkout'
      click_button 'Save'
      visit item_checkoutx.checkouts_path
      #save_and_open_page

      expect(page).to have_content('Reviewing')
      click_link 'Approve'
      fill_in 'checkout_wf_comment', :with => 'Approving checkout'
      click_button 'Save'
      visit item_checkoutx.checkouts_path
      #save_and_open_page

      expect(page).to have_content('Approved')
      click_link 'Release'
      fill_in 'checkout_wf_comment', :with => 'Checking checkout'
      fill_in 'checkout_out_qty', :with => q.requested_qty
      click_button 'Save'
      visit item_checkoutx.checkouts_path
      #save_and_open_page
      expect(page).to have_content('Released')
    end

    it "rewind after rejecting a submited checkout request" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'initial_state')
      visit item_checkoutx.checkouts_path
      expect(page).to have_content('Submit Checkout')
      click_link 'Submit Checkout'
      fill_in 'checkout_wf_comment', :with => 'Submitting checkout'
      click_button 'Save'
      visit item_checkoutx.checkouts_path
      save_and_open_page

      expect(page).to have_content('Reviewing')
      click_link 'Rewind'
      fill_in 'checkout_wf_comment', :with => 'Rejecting checkout'
      click_button 'Save'
      visit item_checkoutx.checkouts_path
      #save_and_open_page

      expect(page).to have_content('Initial State')

    end

    it "list submitted request then reviewing requests, then rejected requests" do
      q = FactoryGirl.create(:item_checkoutx_checkout, :item_id => @i.id, :wf_state => 'initial_state')
      visit item_checkoutx.list_items_checkouts_path(:wf_state => 'initial_state')
      expect(page).to have_content('Submit Checkout')
      click_link 'Submit Checkout'
      fill_in 'checkout_wf_comment', :with => 'Submitting checkout'
      click_button 'Save'

      visit item_checkoutx.list_items_checkouts_path(:wf_state => 'reviewing')
      #save_and_open_page
      expect(page).to have_content('Reviewing')

      click_link 'Reject'
      fill_in 'checkout_wf_comment', :with => 'Rejecting checkout'
      click_button 'Save'
      visit item_checkoutx.list_items_checkouts_path(:wf_state => 'rejected')
      expect(page).to have_content('Rejected')
    end
=end
  end
end
