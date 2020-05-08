class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.integer :yob
      t.boolean :is_alive

      t.timestamps
    end
  end
end
