class EditImagesColumnInIdeas < ActiveRecord::Migration
  def change
    remove_column :ideas, :images
  end
end
