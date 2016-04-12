class CreateBooksAndAuthorsBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.string :title, :limit => 255, :null => false
      t.integer :publisher_id, :null => false
      t.datetime :published_at
      t.string :isbn, :limit => 13, :unique => true
      t.text :blurb
      t.integer :page_count
      t.float :price
      t.timestamps
    end

    create_table :authors_books do |t|
      t.integer :author_id, :null => false
      t.integer :book_id, :null => false
      t.timestamps
    end

    say_with_time 'Adding foreing keys' do
      # Add foreign key reference to authors_books table
      execute 'ALTER TABLE authors_books ADD CONSTRAINT fk_authors_books_authors
              FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE'      
      execute 'ALTER TABLE authors_books ADD CONSTRAINT fk_authors_books_books
              FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE'
      # Add foreign key reference to publishers table
      execute 'ALTER TABLE books ADD CONSTRAINT fk_books_publishers
              FOREIGN KEY (publisher_id) REFERENCES publishers(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :books
    drop_table :authors_books
  end
end
