class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name, required: true
      t.integer :priority #, required: true, numericality: true
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
