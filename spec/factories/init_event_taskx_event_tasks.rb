# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :init_event_taskx_event_task, :class => 'InitEventTaskx::EventTask' do
    wfid "MyString"
    task_category "MyString"
    name "MyString"
    instruction "MyText"
    description "MyText"
    start_date "2013-10-11"
    finish_date "2013-10-11"
    cancelled false
    completed false
    expedite false
    last_updated_by_id 1
    requested_by_id 1
    executioner_id 1
    task_status_id 1
  end
end
