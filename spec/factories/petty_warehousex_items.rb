# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :petty_warehousex_item, :class => 'PettyWarehousex::Item' do
    name "MyString"
    in_date "2014-01-13"
    in_qty 1
    spec "MyString"
    last_updated_by_id 1
    stock_qty 1
    note "MyText"
    storage_location "MyString"
    inspection "MyText"
    unit "MyString"
    supplier_id 1
    unit_price "9.99"
    item_category_id 1
    other_cost "9.99"
    whs_string 'headquarter'
    total_cost 8.99
  end
end
