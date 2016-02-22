class RenameImageColumnInIdeas < ActiveRecord::Migration
  def change
    rename_column :ideas, :image, :images
  end
end
