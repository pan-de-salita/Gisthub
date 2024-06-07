class RenameCategoriesToTagsInSolutions < ActiveRecord::Migration[7.1]
  def change
    rename_column :solutions, :categories, :tags
  end
end
