class RenameSolutionInSolutions < ActiveRecord::Migration[7.1]
  def change
    rename_column :solutions, :solution, :attempt
  end
end
