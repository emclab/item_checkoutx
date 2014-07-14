class CreateItemCheckoutxCheckouts < ActiveRecord::Migration
  def change
    create_table :item_checkoutx_checkouts do |t|
      t.string :name
      t.date :request_date
      t.string :item_spec
      t.integer :requested_by_id
      t.integer :out_qty
      t.string :unit
      t.text :brief_note
      t.integer :last_updated_by_id
      t.integer :item_id
      t.string :wf_state
      t.integer :requested_qty
      t.integer :checkout_by_id
      t.date :out_date
      t.string :wf_state
      t.boolean :released, :default => false
      t.timestamps
    end
    
    add_index :item_checkoutx_checkouts, :item_id
    add_index :item_checkoutx_checkouts, :wf_state
    add_index :item_checkoutx_checkouts, :name
    add_index :item_checkoutx_checkouts, :item_spec
  end
end