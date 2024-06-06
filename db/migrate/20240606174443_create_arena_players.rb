class CreateArenaPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :arena_players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :arena, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
