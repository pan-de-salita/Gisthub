class RemovePronounsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :pronouns, :string
  end
end
