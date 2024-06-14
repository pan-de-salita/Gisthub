class RemoveUserRelationFromLanguage < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :languages, :users
    remove_index :languages, :user_id
    remove_column :languages, :user_id
  end
end
