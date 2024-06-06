class AddUserIdToSolutions < ActiveRecord::Migration[7.1]
  def change
    add_reference :solutions, :user, null: false, foreign_key: true
  end
end
