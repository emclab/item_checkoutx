HeavyMachineryProjectx.customer_class = 'Kustomerx::Customer'
HeavyMachineryProjectx.show_customer_path = 'kustomerx.customer_path(r.customer_id)'
HeavyMachineryProjectx.index_installation_path = "event_taskx.event_tasks_path(:resource_id => r.id, :resource_string => params[:controller], :task_category => 'installation_plan', :subaction => 'installation_plan')"
HeavyMachineryProjectx.index_production_plan_path = "event_taskx.event_tasks_path(:resource_id => r.id, :resource_string => params[:controller], :task_category => 'production_plan', :subaction => 'production_plan')"
HeavyMachineryProjectx.index_supplied_path = 'supplied_partx.parts_path(:project_id => r.id)'
HeavyMachineryProjectx.index_sourced_path = 'sourced_partx.parts_path(:project_id => r.id)'

