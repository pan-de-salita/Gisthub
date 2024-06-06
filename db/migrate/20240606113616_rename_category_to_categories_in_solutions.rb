class RenameCategoryToCategoriesInSolutions < ActiveRecord::Migration[7.1]
  def change
    rename_column :solutions, :category, :categories
  end
end
