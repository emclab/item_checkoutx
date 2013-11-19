InQuotex.task_class = 'InitEventTaskx::EventTask'
InQuotex.supplier_class = 'Supplierx::Supplier'
InQuotex.show_task_path = 'init_event_taskx.event_task_path(InitEventTaskx::EventTask.find_by_id(r.task_id))'
InQuotex.return_suppliers = "Supplierx::Supplier.where(:active => true).order('name')"
