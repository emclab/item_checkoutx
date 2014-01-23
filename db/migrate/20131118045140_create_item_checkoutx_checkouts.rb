class CreateItemCheckoutxCheckouts < ActiveRecord::Migration
  def change
    create_table :item_checkoutx_checkouts do |t|
      t.date :out_date
      t.integer :requested_by_id
      t.integer :out_qty
      t.integer :order_id
      t.text :brief_note
      t.timestamps
      t.integer :last_updated_by_id
      t.integer :item_id
      t.string :wf_state
      t.string :wfid
      t.integer :requested_qty
      t.integer :checkout_by_id
  
    end
    
    add_index :item_checkoutx_checkouts, :item_id
    add_index :item_checkoutx_checkouts, :order_id
    add_index :item_checkoutx_checkouts, :wfid
    add_index :item_checkoutx_checkouts, :wf_state
  end
end
