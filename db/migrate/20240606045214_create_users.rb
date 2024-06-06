class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :pronouns
      t.text :bio
      t.string :email

      t.timestamps
    end
  end
end
