# This migration comes from mfg_processx (originally 20131009202535)
class CreateMfgProcessxMfgProcesses < ActiveRecord::Migration
  def change
    create_table :mfg_processx_mfg_processes do |t|
      t.integer :rfq_id
      t.string :name
      t.text :description
      t.integer :last_updated_by_id
      t.integer :composed_by_id
      t.boolean :void, :default => false
      t.text :note
      t.string :wfid

      t.timestamps
    end
    
    add_index :mfg_processx_mfg_processes, :rfq_id
  end
end
