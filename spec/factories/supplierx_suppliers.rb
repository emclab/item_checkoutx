# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplierx_supplier, :class => 'Supplierx::Supplier' do
    name "my supplier"
    short_name "My short name"
    contact_name "My contact"
    contact_info 'info'
    phone "My phone"
    fax "MyString"
    cell "My cell"
    email "My@email.com"
    address "My address"
    web "MyString"
    main_product "MyText"
    supply_since "2013-08-04"
    #last_eval_date "2013-08-04"
    active true
    last_updated_by_id 1
    quality_system_id 1
    note 'some note here'
    short_comment "good"
    
  end
end
