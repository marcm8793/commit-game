class AddCategoryAndLanguageToArenas < ActiveRecord::Migration[7.1]
  def change
    add_reference :arenas, :category, null: false, foreign_key: true
    add_reference :arenas, :language, null: false, foreign_key: true
  end
end
