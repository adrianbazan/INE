class CreateProducers < ActiveRecord::Migration
  def change
    create_table :producers do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
