class CreateJoinTableUsersLanguages < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :languages do |t|
      t.index %i[user_id language_id]
      t.index %i[language_id user_id]
    end
  end
end
