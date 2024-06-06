class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :score
      t.integer :week_number
      t.references :arena_player, null: false, foreign_key: true
      t.boolean :done

      t.timestamps
    end
  end
end
