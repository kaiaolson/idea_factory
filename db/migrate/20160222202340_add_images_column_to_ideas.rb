class AddImagesColumnToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :images, :text, array: true, default: []
  end
end
