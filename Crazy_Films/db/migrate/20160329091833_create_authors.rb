class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
			t.string :dni
			t.string :firstname
			t.string :surnames
			t.date :birthdate
      t.timestamps
    end
  end
end
