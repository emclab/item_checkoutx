# This migration comes from in_quotex (originally 20131110014124)
class CreateInQuotexQuotes < ActiveRecord::Migration
  def change
    create_table :in_quotex_quotes do |t|
      t.integer :task_id
      t.integer :last_updated_by_id
      t.string :wfid
      t.string :wf_state
      t.integer :qty
      t.string :unit
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.integer :supplier_id
      t.decimal :shipping_cost, :precision => 10, :scale => 2
      t.decimal :tax, :precision => 10, :scale => 2
      t.decimal :other_cost, :precision => 10, :scale => 2
      t.integer :lead_time_day
      t.text :payment_term
      t.text :quote_condition
      t.integer :good_for_day
      t.string :supplier_quote_num
      t.string :supplier_contact
      t.boolean :void, :default => false
      t.integer :quoted_by_id
      
      t.timestamps
    end
    
    add_index :in_quotex_quotes, :task_id
    add_index :in_quotex_quotes, :wfid
    add_index :in_quotex_quotes, :supplier_id
    add_index :in_quotex_quotes, :wf_state
  end
end
