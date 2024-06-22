class AddSlotsToArenas < ActiveRecord::Migration[7.1]
  def change
    add_column :arenas, :slots, :integer
  end
end
