# This migration comes from petty_warehousex (originally 20140113223233)
class CreatePettyWarehousexItems < ActiveRecord::Migration
  def change
    create_table :petty_warehousex_items do |t|
      t.string :name
      t.date :in_date
      t.decimal :in_qty, :precision => 12, :scale => 4
      t.string :spec
      t.integer :last_updated_by_id
      t.integer :stock_qty, :precision => 12, :scale => 4
      t.text :note
      t.string :storage_location
      t.text :inspection
      t.timestamps
      t.string :unit
      t.integer :supplier_id
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.integer :item_category_id
      t.integer :item_sub_category_id
      t.decimal :other_cost, :precision => 10, :scale => 2
      t.integer :received_by_id
      t.string :whs_string   #warehouse name. used to allow access to each individual whs.
      t.decimal :total_cost, :precision => 10, :scale => 2
      t.integer :project_id
      t.boolean :accepted, :default => false
      t.date :accepted_date
      t.integer :purchase_order_id
      t.string :part_num
      t.string :aux_resource
      t.string :fort_token
      t.integer :whs_id
      
    end
    
    add_index :petty_warehousex_items, :name
    add_index :petty_warehousex_items, :item_category_id
    add_index :petty_warehousex_items, :received_by_id
    add_index :petty_warehousex_items, :whs_string
    add_index :petty_warehousex_items, :spec
    add_index :petty_warehousex_items, :project_id
    add_index :petty_warehousex_items, :purchase_order_id
    add_index :petty_warehousex_items, :accepted
    add_index :petty_warehousex_items, :part_num
    add_index :petty_warehousex_items, :aux_resource
    add_index :petty_warehousex_items, :fort_token
    add_index :petty_warehousex_items, :whs_id
  end
end
