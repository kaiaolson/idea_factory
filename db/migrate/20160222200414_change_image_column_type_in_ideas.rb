class ChangeImageColumnTypeInIdeas < ActiveRecord::Migration
  def change
    change_column :ideas, :images, :text
  end
end
