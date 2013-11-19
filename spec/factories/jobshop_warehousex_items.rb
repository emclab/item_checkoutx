# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jobshop_warehousex_item, :class => 'JobshopWarehousex::Item' do
    name "MyString"
    spec "MyString"
    in_qty 1
    unit "MyString"
    inspection "MyText"
    last_updated_by_id 1
    received_by_id 1
    storage_location "MyString"
    stock_qty 1
    purchase_order_id 1
    in_date "2013-11-17"
    rejected false
  end
end
