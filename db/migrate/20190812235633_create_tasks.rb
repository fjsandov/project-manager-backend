class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.datetime :deadline
      t.string :status
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
