# This migration comes from init_event_taskx (originally 20131011165309)
class CreateInitEventTaskxEventTasks < ActiveRecord::Migration
  def change
    create_table :init_event_taskx_event_tasks do |t|
      t.string :wfid
      t.string :task_category
      t.string :name
      t.text :instruction
      t.text :description
      t.date :start_date
      t.date :finish_date
      t.boolean :cancelled, :default => false
      t.boolean :completed, :default => false
      t.boolean :expedite, :default => false
      t.integer :last_updated_by_id
      t.integer :requested_by_id
      t.integer :executioner_id
      t.integer :task_status_id

      t.timestamps
    end
    
    add_index :init_event_taskx_event_tasks, :task_category
    add_index :init_event_taskx_event_tasks, :wfid
  end
end
