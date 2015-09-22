class CreateItemCheckoutxCheckouts < ActiveRecord::Migration
  def change
    create_table :item_checkoutx_checkouts do |t|
      t.integer :item_id
      t.date :request_date
      t.integer :requested_by_id
      t.integer :out_qty, :precision => 12, :scale => 4
      t.string :unit
      t.text :brief_note
      t.integer :last_updated_by_id
      t.string :wf_state
      t.integer :requested_qty, :precision => 12, :scale => 4
      t.integer :checkout_by_id
      t.date :out_date
      t.boolean :released, :default => false
      t.boolean :skip_wf, :default => false
      t.timestamps
      t.string :whs_string   #warehouse name. used to allow access to each individual whs.
      t.string :aux_resource
      
    end
    
    add_index :item_checkoutx_checkouts, :item_id
    add_index :item_checkoutx_checkouts, :wf_state
    add_index :item_checkoutx_checkouts, :skip_wf
    add_index :item_checkoutx_checkouts, :whs_string
    add_index :item_checkoutx_checkouts, :aux_resource
  end
end
