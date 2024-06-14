class DropJoinTableUsersLanguages < ActiveRecord::Migration[7.1]
  def change
    drop_table :languages_users
  end
end
