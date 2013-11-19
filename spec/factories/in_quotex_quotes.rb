# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :in_quotex_quote, :class => 'InQuotex::Quote' do
    task_id 1
    last_updated_by_id 1
    wfid "MyString"
    comment "MyText"
    state "MyString"
    qty 1
    unit "unit"
    unit_price "9.99"
    supplier_id 1
    shipping_cost "9.99"
    tax "9.99"
    other_cost "9.99"
    lead_time_day 1
    payment_term "MyText"
    quote_condition "MyText"
    good_for_day 1
    supplier_quote_num "My quote # String"
    supplier_contact "My name String"
    void false
    quoted_by_id 1
  end
end
