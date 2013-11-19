# This migration comes from purchase_orderx (originally 20131115022208)
class CreatePurchaseOrderxOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orderx_orders do |t|
      t.string :po_num
      t.integer :quote_id
      t.integer :last_updated_by_id
      t.string :wfid
      t.string :state
      t.text :comment
      t.integer :supplier_id
      t.integer :qty
      t.string :unit
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.date :delivery_date
      t.text :brief_note
      t.boolean :delivered, :default => false
      t.date :actual_delivery_date
      t.date :po_date
      t.text :po_requirement
      t.decimal :po_total, :precision => 10, :scale => 2
      t.decimal :shipping_cost, :precision => 10, :scale => 2
      t.decimal :tax, :precision => 10, :scale => 2
      t.decimal :other_cost, :precision => 10, :scale => 2
      t.integer :requested_by_id

      t.timestamps
    end
    
    add_index :purchase_orderx_orders, :quote_id
    add_index :purchase_orderx_orders, :wfid
    add_index :purchase_orderx_orders, :supplier_id
    add_index :purchase_orderx_orders, :po_num
    add_index :purchase_orderx_orders, :requested_by_id
  end
end
