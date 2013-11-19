# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_checkoutx_checkout, :class => 'ItemCheckoutx::Checkout' do
    item_id 1
    out_qty 1
    last_updated_by_id 1
    order_id 1
    requested_by_id 1
    out_date "2013-11-17"
    brief_note "My note Text"
    state "My state String"
    comment "My comment Text"
    wfid "MyString"
    requested_qty 1
    checkout_by_id 1
  end
end
