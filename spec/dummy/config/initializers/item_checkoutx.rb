ItemCheckoutx.item_class = 'JobshopWarehousex::Item'
ItemCheckoutx.show_item_path = 'jobshop_warehousex.item_path(r.item_id, :parent_record_id => r.item_id, :parent_resource => ItemCheckoutx.item_class.to_s.underscore.pluralize)'
ItemCheckoutx.order_class = 'MfgOrderx::Order'
ItemCheckoutx.mfg_batch_class = 'MfgBatchx::Batch'
ItemCheckoutx.show_order_path = 'mfg_orderx.order_path(r.order_id)'
ItemCheckoutx.order_collection = "MfgOrderx::Order.where(:cancelled => false, :completed => false).order('id')"