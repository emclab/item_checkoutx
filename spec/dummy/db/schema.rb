# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140613234603) do

  create_table "authentify_engine_configs", :force => true do |t|
    t.string   "engine_name"
    t.string   "engine_version"
    t.string   "argument_name"
    t.text     "argument_value"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "brief_note"
    t.boolean  "global",             :default => false
  end

  add_index "authentify_engine_configs", ["argument_name"], :name => "index_authentify_engine_configs_on_argument_name"
  add_index "authentify_engine_configs", ["engine_name", "argument_name"], :name => "authentify_engine_configs_names"
  add_index "authentify_engine_configs", ["engine_name"], :name => "index_authentify_engine_configs_on_engine_name"

  create_table "authentify_group_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "brief_note"
  end

  create_table "authentify_role_definitions", :force => true do |t|
    t.string   "name"
    t.string   "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "manager_role_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "authentify_role_definitions", ["manager_role_id"], :name => "index_authentify_role_definitions_on_manager_role_id"

  create_table "authentify_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentify_sessions", ["session_id"], :name => "index_authentify_sessions_on_session_id"
  add_index "authentify_sessions", ["updated_at"], :name => "index_authentify_sessions_on_updated_at"

  create_table "authentify_sys_logs", :force => true do |t|
    t.datetime "log_date"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "user_ip"
    t.string   "action_logged"
  end

  add_index "authentify_sys_logs", ["user_id"], :name => "index_authentify_sys_logs_on_user_id"
  add_index "authentify_sys_logs", ["user_name"], :name => "index_authentify_sys_logs_on_user_name"

  create_table "authentify_sys_module_mappings", :force => true do |t|
    t.integer  "sys_module_id"
    t.integer  "sys_user_group_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "brief_note"
  end

  add_index "authentify_sys_module_mappings", ["sys_module_id"], :name => "index_authentify_sys_module_mappings_on_sys_module_id"
  add_index "authentify_sys_module_mappings", ["sys_user_group_id"], :name => "index_authentify_sys_module_mappings_on_sys_user_group_id"

  create_table "authentify_sys_modules", :force => true do |t|
    t.string   "module_name"
    t.string   "module_group_name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "brief_note"
  end

  add_index "authentify_sys_modules", ["module_group_name"], :name => "index_authentify_sys_modules_on_module_group_name"
  add_index "authentify_sys_modules", ["module_name"], :name => "index_authentify_sys_modules_on_module_name"

  create_table "authentify_sys_user_groups", :force => true do |t|
    t.string   "user_group_name"
    t.string   "short_note"
    t.integer  "zone_id"
    t.integer  "group_type_id"
    t.integer  "manager_group_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "authentify_sys_user_groups", ["group_type_id"], :name => "index_authentify_sys_user_groups_on_group_type_id"
  add_index "authentify_sys_user_groups", ["manager_group_id"], :name => "index_authentify_sys_user_groups_on_manager_group_id"
  add_index "authentify_sys_user_groups", ["zone_id"], :name => "index_authentify_sys_user_groups_on_zone_id"

  create_table "authentify_user_accesses", :force => true do |t|
    t.string   "action"
    t.string   "resource"
    t.string   "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "role_definition_id"
    t.text     "sql_code"
    t.text     "masked_attrs"
    t.integer  "rank"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "authentify_user_accesses", ["action", "resource"], :name => "index_authentify_user_accesses_on_action_and_resource"
  add_index "authentify_user_accesses", ["action"], :name => "index_authentify_user_accesses_on_action"
  add_index "authentify_user_accesses", ["rank"], :name => "index_authentify_user_accesses_on_rank"
  add_index "authentify_user_accesses", ["resource"], :name => "index_authentify_user_accesses_on_resource"
  add_index "authentify_user_accesses", ["role_definition_id"], :name => "index_authentify_user_accesses_on_role_definition_id"

  create_table "authentify_user_levels", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sys_user_group_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "brief_note"
  end

  add_index "authentify_user_levels", ["sys_user_group_id"], :name => "index_authentify_user_levels_on_sys_user_group_id"
  add_index "authentify_user_levels", ["user_id"], :name => "index_authentify_user_levels_on_user_id"

  create_table "authentify_user_roles", :force => true do |t|
    t.integer  "last_updated_by_id"
    t.integer  "role_definition_id"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "brief_note"
  end

  add_index "authentify_user_roles", ["role_definition_id"], :name => "index_authentify_user_roles_on_role_definition_id"
  add_index "authentify_user_roles", ["user_id"], :name => "index_authentify_user_roles_on_user_id"

  create_table "authentify_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "status",                 :default => "active"
    t.integer  "last_updated_by_id"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "brief_note"
    t.string   "cell"
    t.boolean  "allow_text_msg",         :default => false
    t.boolean  "allow_email",            :default => false
    t.integer  "customer_id"
    t.string   "local"
  end

  add_index "authentify_users", ["allow_email"], :name => "index_authentify_users_on_allow_email"
  add_index "authentify_users", ["allow_text_msg"], :name => "index_authentify_users_on_allow_text_msg"
  add_index "authentify_users", ["customer_id"], :name => "index_authentify_users_on_customer_id"
  add_index "authentify_users", ["email"], :name => "index_authentify_users_on_email"
  add_index "authentify_users", ["name"], :name => "index_authentify_users_on_name"
  add_index "authentify_users", ["status"], :name => "index_authentify_users_on_status"

  create_table "authentify_zones", :force => true do |t|
    t.string   "zone_name"
    t.string   "brief_note"
    t.boolean  "active",        :default => true
    t.integer  "ranking_order"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "authentify_zones", ["id", "active"], :name => "index_authentify_zones_on_id_and_active"

  create_table "commonx_logs", :force => true do |t|
    t.text     "log"
    t.integer  "resource_id"
    t.string   "resource_name"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "commonx_logs", ["resource_id", "resource_name"], :name => "index_commonx_logs_on_resource_id_and_resource_name"
  add_index "commonx_logs", ["resource_id"], :name => "index_commonx_logs_on_resource_id"
  add_index "commonx_logs", ["resource_name"], :name => "index_commonx_logs_on_resource_name"

  create_table "commonx_misc_definitions", :force => true do |t|
    t.string   "name"
    t.boolean  "active",             :default => true
    t.string   "for_which"
    t.text     "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "ranking_index"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "commonx_misc_definitions", ["active", "for_which"], :name => "index_commonx_misc_definitions_on_active_and_for_which"
  add_index "commonx_misc_definitions", ["active"], :name => "index_commonx_misc_definitions_on_active"
  add_index "commonx_misc_definitions", ["for_which"], :name => "index_commonx_misc_definitions_on_for_which"

  create_table "commonx_search_stat_configs", :force => true do |t|
    t.string   "resource_name"
    t.text     "stat_function"
    t.text     "stat_summary_function"
    t.text     "labels_and_fields"
    t.string   "time_frame"
    t.string   "search_list_form"
    t.text     "search_where"
    t.text     "search_results_period_limit"
    t.integer  "last_updated_by_id"
    t.string   "brief_note"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "stat_header"
    t.text     "search_params"
    t.text     "search_summary_function"
  end

  add_index "commonx_search_stat_configs", ["resource_name"], :name => "index_commonx_search_stat_configs_on_resource_name"

  create_table "heavy_machinery_projectx_projects", :force => true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.integer  "status_id"
    t.text     "install_address"
    t.text     "tech_spec"
    t.text     "other_spec"
    t.text     "turn_over_requirement"
    t.date     "bid_doc_available_date"
    t.date     "bid_deadline"
    t.date     "tender_open_date"
    t.date     "production_start_date"
    t.date     "install_start_date"
    t.boolean  "completed",                :default => false
    t.boolean  "cancelled",                :default => false
    t.integer  "last_updated_by_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "awarded",                  :default => false
    t.date     "design_start_date"
    t.integer  "project_manager_id"
    t.date     "test_run_date"
    t.date     "turn_over_date"
    t.integer  "qty"
    t.integer  "category_id"
    t.text     "construction_requirement"
    t.string   "project_num"
  end

  add_index "heavy_machinery_projectx_projects", ["awarded"], :name => "index_heavy_machinery_projectx_projects_on_awarded"
  add_index "heavy_machinery_projectx_projects", ["cancelled"], :name => "index_heavy_machinery_projectx_projects_on_cancelled"
  add_index "heavy_machinery_projectx_projects", ["category_id"], :name => "index_heavy_machinery_projectx_projects_on_category_id"
  add_index "heavy_machinery_projectx_projects", ["completed"], :name => "index_heavy_machinery_projectx_projects_on_completed"
  add_index "heavy_machinery_projectx_projects", ["customer_id"], :name => "index_heavy_machinery_projectx_projects_on_customer_id"
  add_index "heavy_machinery_projectx_projects", ["name"], :name => "index_heavy_machinery_projectx_projects_on_name"
  add_index "heavy_machinery_projectx_projects", ["status_id"], :name => "index_heavy_machinery_projectx_projects_on_status_id"

  create_table "item_checkoutx_checkouts", :force => true do |t|
    t.string   "name"
    t.text     "item_spec"
    t.date     "out_date"
    t.integer  "requested_by_id"
    t.integer  "out_qty"
    t.text     "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "item_id"
    t.string   "wf_state"
    t.integer  "requested_qty"
    t.integer  "checkout_by_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "item_checkoutx_checkouts", ["item_id"], :name => "index_item_checkoutx_checkouts_on_item_id"
  add_index "item_checkoutx_checkouts", ["item_spec"], :name => "index_item_checkoutx_checkouts_on_item_spec"
  add_index "item_checkoutx_checkouts", ["name"], :name => "index_item_checkoutx_checkouts_on_name"
  add_index "item_checkoutx_checkouts", ["wf_state"], :name => "index_item_checkoutx_checkouts_on_wf_state"

  create_table "kustomerx_addresses", :force => true do |t|
    t.string   "province"
    t.string   "city_county_district"
    t.string   "add_line"
    t.integer  "customer_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "kustomerx_addresses", ["customer_id"], :name => "index_kustomerx_addresses_on_customer_id"

  create_table "kustomerx_contacts", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.string   "position"
    t.string   "phone"
    t.string   "cell_phone"
    t.string   "email"
    t.text     "brief_note"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "kustomerx_contacts", ["customer_id"], :name => "index_kustomerx_contacts_on_customer_id"

  create_table "kustomerx_customers", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.date     "since_date"
    t.text     "shipping_instruction"
    t.integer  "zone_id"
    t.integer  "customer_status_category_id"
    t.string   "phone"
    t.string   "fax"
    t.integer  "sales_id"
    t.boolean  "active",                      :default => true
    t.integer  "last_updated_by_id"
    t.integer  "quality_system_id"
    t.string   "employee_num"
    t.string   "revenue"
    t.text     "customer_eval"
    t.text     "main_biz"
    t.text     "customer_specific"
    t.text     "note"
    t.string   "web"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "kustomerx_customers", ["active"], :name => "index_kustomerx_customers_on_active"
  add_index "kustomerx_customers", ["name"], :name => "index_kustomerx_customers_on_name"
  add_index "kustomerx_customers", ["sales_id"], :name => "index_kustomerx_customers_on_sales_id"
  add_index "kustomerx_customers", ["since_date"], :name => "index_kustomerx_customers_on_since_date"
  add_index "kustomerx_customers", ["zone_id"], :name => "index_kustomerx_customers_on_zone_id"

  create_table "petty_warehousex_items", :force => true do |t|
    t.string   "name"
    t.date     "in_date"
    t.integer  "in_qty"
    t.string   "item_spec"
    t.integer  "last_updated_by_id"
    t.integer  "stock_qty"
    t.text     "note"
    t.string   "storage_location"
    t.text     "inspection"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "unit"
    t.integer  "supplier_id"
    t.decimal  "unit_price",         :precision => 10, :scale => 2
    t.integer  "item_category_id"
    t.decimal  "other_cost",         :precision => 10, :scale => 2
    t.integer  "received_by_id"
    t.string   "whs_string"
    t.decimal  "total_cost",         :precision => 10, :scale => 2
    t.integer  "project_id"
    t.boolean  "accepted",                                          :default => false
    t.date     "accepted_date"
    t.integer  "purchase_order_id"
  end

  add_index "petty_warehousex_items", ["accepted"], :name => "index_petty_warehousex_items_on_accepted"
  add_index "petty_warehousex_items", ["item_category_id"], :name => "index_petty_warehousex_items_on_item_category_id"
  add_index "petty_warehousex_items", ["item_spec"], :name => "index_petty_warehousex_items_on_item_spec"
  add_index "petty_warehousex_items", ["name"], :name => "index_petty_warehousex_items_on_name"
  add_index "petty_warehousex_items", ["project_id"], :name => "index_petty_warehousex_items_on_project_id"
  add_index "petty_warehousex_items", ["purchase_order_id"], :name => "index_petty_warehousex_items_on_purchase_order_id"
  add_index "petty_warehousex_items", ["received_by_id"], :name => "index_petty_warehousex_items_on_received_by_id"
  add_index "petty_warehousex_items", ["whs_string"], :name => "index_petty_warehousex_items_on_whs_string"

  create_table "state_machine_logx_logs", :force => true do |t|
    t.string   "resource_string"
    t.integer  "resource_id"
    t.string   "event"
    t.string   "action_by_name"
    t.text     "comment"
    t.string   "from"
    t.string   "to"
    t.text     "error_message"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "state_machine_logx_logs", ["resource_id"], :name => "index_state_machine_logx_logs_on_resource_id"
  add_index "state_machine_logx_logs", ["resource_string", "resource_id"], :name => "state_machine_logx_logs_resources"
  add_index "state_machine_logx_logs", ["resource_string"], :name => "index_state_machine_logx_logs_on_resource_string"

  create_table "supplierx_suppliers", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "cell"
    t.text     "address"
    t.string   "web"
    t.integer  "last_updated_by_id"
    t.text     "main_product"
    t.date     "supply_since"
    t.string   "short_comment"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "active",             :default => true
    t.string   "fax"
    t.string   "email"
    t.integer  "quality_system_id"
    t.text     "note"
    t.text     "contact_info"
  end

  add_index "supplierx_suppliers", ["name"], :name => "index_supplierx_suppliers_on_name"

end
