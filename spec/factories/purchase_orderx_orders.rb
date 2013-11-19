# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_orderx_order, :class => 'PurchaseOrderx::Order' do
    quote_id 1
    last_updated_by_id 1
    wfid "MyString"
    state "MyString"
    comment "MyText"
    supplier_id 1
    qty 1
    unit "MyString"
    unit_price "9.99"
    delivery_date "2013-11-14"
    brief_note "My note Text"
    delivered false
    actual_delivery_date "2013-11-14"
    po_date "2013-11-14"
    po_requirement "My po requirement Text"
    po_total "9.99"
    shipping_cost "9.99"
    tax "9.99"
    other_cost "9.99"
    po_num 'po##'
    requested_by_id 1
  end
end
