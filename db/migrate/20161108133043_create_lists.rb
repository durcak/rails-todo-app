class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name, required: true, :unique => true
      t.text :description, required: true

      t.timestamps
    end
  end
end
