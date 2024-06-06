class CreateCommits < ActiveRecord::Migration[7.1]
  def change
    create_table :commits do |t|
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
