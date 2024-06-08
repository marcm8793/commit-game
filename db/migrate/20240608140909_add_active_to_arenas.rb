class AddActiveToArenas < ActiveRecord::Migration[7.1]
  def change
    add_column :arenas, :active, :boolean
  end
end
