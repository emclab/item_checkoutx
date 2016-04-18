# This migration comes from supplierx (originally 20130804210247)
class CreateSupplierxSuppliers < ActiveRecord::Migration
  def change
    create_table :supplierx_suppliers do |t|
      t.string :name
      t.string :short_name
      t.string :contact_name
      t.string :phone
      t.string :cell
      t.text :address
      t.string :web
      t.integer :last_updated_by_id
      t.text :main_product
      t.date :supply_since
      t.string :short_comment     
      t.timestamps
      t.boolean :active, :default => true
      t.string :fax
      t.string :email
      t.integer :quality_system_id
      t.text :note
      t.text :contact_info
      t.integer :supplier_category_id
      t.string :fort_token
   
    end
    
    add_index :supplierx_suppliers, :name
    
  end
end
