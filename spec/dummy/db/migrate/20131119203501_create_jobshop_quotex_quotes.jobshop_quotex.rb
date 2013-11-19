# This migration comes from jobshop_quotex (originally 20131006223508)
class CreateJobshopQuotexQuotes < ActiveRecord::Migration
  def change
    create_table :jobshop_quotex_quotes do |t|
      t.integer :rfq_id
      t.integer :quote_task_id
      t.integer :mfg_process_id
      t.string :wfid
      t.text :comment
      t.string :state
      t.integer :last_updated_by_id
      t.integer :qty_quoted
      t.string :unit
      t.decimal :material_wt, :precision => 8, :scale => 2
      t.string :material_quoted
      t.decimal :material_unit_price, :precision => 8, :scale => 2
      t.decimal :unit_price, :precision => 8, :scale => 2
      t.decimal :material_cost, :precision => 10, :scale => 4
      t.decimal :machining_cost, :precision => 10, :scale => 4
      t.decimal :surface_finish_cost, :precision => 10, :scale => 4
      t.decimal :plating_cost, :precision => 10, :scale => 4
      t.decimal :grinding_cost, :precision => 10, :scale => 4
      t.decimal :heat_treat_cost, :precision => 10, :scale => 4
      t.decimal :packing_cost, :precision => 8, :scale => 4
      t.decimal :insp_cost, :precision => 8, :scale => 4
      t.decimal :mgmt_cost, :precision => 8, :scale => 4
      t.decimal :shipping_cost, :precision => 8, :scale => 4
      t.decimal :misc_cost, :precision => 8, :scale => 4
      t.decimal :profit, :precision => 8, :scale => 4
      t.decimal :tax, :precision => 8, :scale => 4
      t.integer :tooling_cost
      t.integer :quoted_by_id
      t.boolean :void, :default => false
      t.text :note

      t.timestamps
    end
    
    add_index :jobshop_quotex_quotes, :mfg_process_id
    add_index :jobshop_quotex_quotes, :quote_task_id
    add_index :jobshop_quotex_quotes, :void
    add_index :jobshop_quotex_quotes, :wfid
    add_index :jobshop_quotex_quotes, :rfq_id
  end
end
