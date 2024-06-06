class CreateArenas < ActiveRecord::Migration[7.1]
  def change
    create_table :arenas do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.text :image
      t.references :user, null: false, foreign_key: true
      t.integer :prize

      t.timestamps
    end
  end
end
