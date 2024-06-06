class RenameNicknameInUser < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :nickname, :alias
  end
end
