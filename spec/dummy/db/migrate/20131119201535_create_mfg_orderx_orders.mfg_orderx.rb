# This migration comes from mfg_orderx (originally 20131016211022)
class CreateMfgOrderxOrders < ActiveRecord::Migration
  def change
    create_table :mfg_orderx_orders do |t|
      t.integer :rfq_id
      t.integer :quote_id
      t.string :wfid
      t.date :order_date
      t.date :delivery_date
      t.date :shipping_date
      t.integer :qty
      t.text :order_requirement
      t.boolean :expedite, :default => false
      t.boolean :cancelled, :default => false
      t.boolean :completed, :default => false
      t.integer :last_updated_by_id
      t.string :customer_po
      t.integer :executioner_id
      t.boolean :sample_required, :default => false

      t.timestamps
    end
    
    add_index :mfg_orderx_orders, :quote_id
    add_index :mfg_orderx_orders, :customer_po
    add_index :mfg_orderx_orders, :rfq_id
    add_index :mfg_orderx_orders, :wfid
  end
end
