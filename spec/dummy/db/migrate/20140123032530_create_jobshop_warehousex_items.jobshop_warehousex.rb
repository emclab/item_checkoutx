# This migration comes from jobshop_warehousex (originally 20131117233432)
class CreateJobshopWarehousexItems < ActiveRecord::Migration
  def change
    create_table :jobshop_warehousex_items do |t|
      t.string :name
      t.date :in_date
      t.integer :in_qty
      t.string :spec
      t.integer :last_updated_by_id
      t.integer :stock_qty
      t.string :storage_location
      t.text :inspection
      t.timestamps
      t.string :unit
      t.integer :warehouse_id
      t.integer :received_by_id
      t.integer :purchase_order_id
      t.boolean :rejected, :default => false
      t.integer :item_category_id
  
    end
    
    add_index :jobshop_warehousex_items, :purchase_order_id
    add_index :jobshop_warehousex_items, :rejected
    add_index :jobshop_warehousex_items, :spec
    add_index :jobshop_warehousex_items, :name
    add_index :jobshop_warehousex_items, :warehouse_id
    add_index :jobshop_warehousex_items, :item_category_id
  end
 
end
