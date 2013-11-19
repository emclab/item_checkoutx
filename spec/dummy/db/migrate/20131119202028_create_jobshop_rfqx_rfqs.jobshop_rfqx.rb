# This migration comes from jobshop_rfqx (originally 20131009195316)
class CreateJobshopRfqxRfqs < ActiveRecord::Migration
  def change
    create_table :jobshop_rfqx_rfqs do |t|
      t.string :product_name
      t.string :drawing_num
      t.text :tech_spec
      t.text :tech_note
      t.string :wfid
      t.integer :last_updated_by_id
      t.integer :customer_id
      t.text :tech_doc
      t.text :material_requirement
      t.integer :sales_id
      t.decimal :product_wt, :precision => 8, :scale => 2
      t.string :qty_for_quote
      t.string :dimension_unit
      t.date :est_production_date
      t.boolean :void, :default => false

      t.timestamps
    end
    
    add_index :jobshop_rfqx_rfqs, :customer_id
    add_index :jobshop_rfqx_rfqs, :drawing_num
    add_index :jobshop_rfqx_rfqs, :product_name
    add_index :jobshop_rfqx_rfqs, :sales_id
    add_index :jobshop_rfqx_rfqs, :wfid
  end
end
