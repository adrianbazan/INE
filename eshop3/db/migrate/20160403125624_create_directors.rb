class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.timestamps
    end
  end
end
