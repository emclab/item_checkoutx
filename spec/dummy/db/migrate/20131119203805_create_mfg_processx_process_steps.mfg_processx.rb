# This migration comes from mfg_processx (originally 20131009204626)
class CreateMfgProcessxProcessSteps < ActiveRecord::Migration
  def change
    create_table :mfg_processx_process_steps do |t|
      t.integer :mfg_process_id
      t.string :name
      t.text :step_desp
      t.text :op_desp
      t.text :insp_desp
      t.text :cutter_desp
      t.integer :machine_tool_category_id
      t.decimal :step_duration_sec, :precision => 8, :scale => 2
      t.integer :ranking_order
      t.decimal :op_cost_hourly, :precision => 8, :scale => 2

      t.timestamps
    end
    
    add_index :mfg_processx_process_steps, :mfg_process_id
  end
end
