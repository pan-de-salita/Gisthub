class CreateSolutions < ActiveRecord::Migration[7.1]
  def change
    create_table :solutions do |t|
      t.string :title
      t.text :instructions
      t.text :solution
      t.string :language
      t.string :category

      t.timestamps
    end
  end
end
