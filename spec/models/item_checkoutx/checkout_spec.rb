require 'rails_helper'

module ItemCheckoutx
  RSpec.describe Checkout, type: :model do
    it "should be OK" do
      c = FactoryGirl.create(:item_checkoutx_checkout)
      expect(c).to be_valid
    end
    
    it "should reject 0 item_id" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :item_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should not allow 0 out qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 0)
      expect(c).not_to be_valid
    end
    
    it "should allow negative out qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => -1)
      expect(c).to be_valid
    end
    
    it "should reject 0 requested_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :requested_qty => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject nil requested_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :requested_qty => nil)
      expect(c).not_to be_valid
    end
    
    it "should take nil in_request_date" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :request_date => nil)
      expect(c).to be_valid
    end
    
    it "should reject if requested_qty <= out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 2, :requested_qty => 1)
      expect(c).not_to be_valid
    end
    
    it "should be OK if requested_qty == out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => 1, :requested_qty => 1)
      expect(c).to be_valid
    end
    
    it "should take nil out_qty" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :out_qty => nil)
      expect(c).to be_valid
    end
    
    it "should take nil skip_wf" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :skip_wf => nil)
      expect(c).to be_valid
    end
    
    it "should take nil unit " do
      c = FactoryGirl.build(:item_checkoutx_checkout, :unit => nil) 
      expect(c).to be_valid
    end
    
    it "should reject 0 item_id" do
      c = FactoryGirl.build(:item_checkoutx_checkout, :item_id => 0) 
      expect(c).not_to be_valid
    end
  end
end
