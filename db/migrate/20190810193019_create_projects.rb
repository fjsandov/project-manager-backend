class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_type
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
