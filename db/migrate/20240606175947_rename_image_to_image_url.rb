class RenameImageToImageUrl < ActiveRecord::Migration[7.1]
  def change
    rename_column :arenas, :image, :image_url
  end
end
