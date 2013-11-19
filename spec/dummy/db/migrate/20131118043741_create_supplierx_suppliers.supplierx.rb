# This migration comes from supplierx (originally 20130804210247)
class CreateSupplierxSuppliers < ActiveRecord::Migration
  def change
    create_table :supplierx_suppliers do |t|
      t.string :name
      t.string :short_name
      t.text :contact_info
      t.string :contact_name
      t.string :phone
      t.string :fax
      t.string :cell
      t.string :email
      t.text :address
      t.string :web
      t.text :main_product
      t.string :short_comment
      t.date :supply_since
      t.boolean :active, :default => true
      t.integer :last_updated_by_id
      t.integer :quality_system_id
      t.text :note

      t.timestamps
    end
    
    add_index :supplierx_suppliers, :name
    
  end
end
