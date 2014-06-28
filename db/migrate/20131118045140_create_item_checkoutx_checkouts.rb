class CreateItemCheckoutxCheckouts < ActiveRecord::Migration
  def change
    create_table :item_checkoutx_checkouts do |t|
      t.string :name
      t.text :item_spec
      t.date :out_date
      t.integer :requested_by_id
      t.integer :out_qty
      t.text :brief_note
      t.integer :last_updated_by_id
      t.integer :item_id
      t.string :wf_state
      t.integer :requested_qty
      t.integer :checkout_by_id
      t.string :wf_state
      t.timestamps
    end
    
    add_index :item_checkoutx_checkouts, :item_id
    add_index :item_checkoutx_checkouts, :wf_state
    add_index :item_checkoutx_checkouts, :name
    add_index :item_checkoutx_checkouts, :item_spec
  end
end
