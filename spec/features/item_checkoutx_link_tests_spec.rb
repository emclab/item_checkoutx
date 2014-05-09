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
  end
end
