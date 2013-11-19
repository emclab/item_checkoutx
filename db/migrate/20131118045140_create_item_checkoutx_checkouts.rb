class CreateItemCheckoutxCheckouts < ActiveRecord::Migration
  def change
    create_table :item_checkoutx_checkouts do |t|
      t.integer :item_id
      t.integer :out_qty
      t.integer :last_updated_by_id
      t.integer :order_id
      t.integer :requested_by_id
      t.date :out_date
      t.text :brief_note
      t.string :state
      t.text :comment
      t.string :wfid
      t.integer :requested_qty
      t.integer :checkout_by_id

      t.timestamps
    end
    
    add_index :item_checkoutx_checkouts, :item_id
    add_index :item_checkoutx_checkouts, :order_id
    add_index :item_checkoutx_checkouts, :wfid
  end
end
