class RenameLanguageToProgrammingLanguageInSolutions < ActiveRecord::Migration[7.1]
  def change
    rename_column :solutions, :language, :programming_language
  end
end
