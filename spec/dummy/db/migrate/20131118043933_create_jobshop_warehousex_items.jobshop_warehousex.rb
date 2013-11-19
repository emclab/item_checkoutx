# This migration comes from jobshop_warehousex (originally 20131117233432)
class CreateJobshopWarehousexItems < ActiveRecord::Migration
  def change
    create_table :jobshop_warehousex_items do |t|
      t.string :name
      t.string :spec
      t.integer :in_qty
      t.string :unit
      t.text :inspection
      t.integer :last_updated_by_id
      t.integer :received_by_id
      t.string :storage_location
      t.integer :stock_qty
      t.integer :purchase_order_id
      t.date :in_date
      t.boolean :rejected, :default => false

      t.timestamps
    end
    
    add_index :jobshop_warehousex_items, :purchase_order_id
    add_index :jobshop_warehousex_items, :stock_qty 
    add_index :jobshop_warehousex_items, :rejected
    add_index :jobshop_warehousex_items, :spec
    add_index :jobshop_warehousex_items, :name
  end
end
