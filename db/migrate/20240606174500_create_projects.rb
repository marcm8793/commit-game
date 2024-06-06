class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :arena_player, null: false, foreign_key: true
      t.string :repo_url
      t.string :name

      t.timestamps
    end
  end
end
