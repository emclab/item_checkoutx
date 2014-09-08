require 'spec_helper'

module ItemCheckoutx
  describe Checkout do
    it "should be OK" do
      c = FactoryGirl.create(:item_checkoutx_checkout)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:item_checkoutx_checkout, name: nil)
      c.should_not be_valid
    end
    
    it "should reject nil item_spec" do
      c = FactoryGirl.build(:item_checkoutx_checkout, item_spec: nil)
      c.should_not be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:item_checkoutx_checkout, unit: nil)
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
    
    it "should take nil in_request_date" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :request_date => nil)
      c.should be_valid
    end
    
    it "should reject if requested_qty <= out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 2, :requested_qty => 1)
      c.should_not be_valid
    end
    
    it "should be OK if requested_qty == out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 1, :requested_qty => 1)
      c.should be_valid
    end
    
    it "should take nil out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => nil)
      c.should be_valid
    end
  end
end
