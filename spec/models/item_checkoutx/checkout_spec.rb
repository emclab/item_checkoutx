require 'spec_helper'

module ItemCheckoutx
  describe Checkout do
    it "should be OK" do
      c = FactoryGirl.create(:item_checkoutx_checkout)
      c.should be_valid
    end
    
    it "should reject 0 order_id" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :order_id => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 item_id" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :item_id => 0)
      c.should_not be_valid
    end
    
    it "should allow 0 out qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 0)
      c.should be_valid
    end
    
    it "should reject 0 requested_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :requested_qty => 0)
      c.should_not be_valid
    end
    
    it "should reject nil in_out_date" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_date => nil)
      c.should_not be_valid
    end
    
    it "should reject if requested_qty <= out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 2, :requested_qty => 1)
      c.should_not be_valid
    end
    
    it "should be OK if requested_qty == out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 1, :requested_qty => 1)
      c.should be_valid
    end
    
    it "should reject nil out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => nil)
      c.should_not be_valid
    end
  end
end
