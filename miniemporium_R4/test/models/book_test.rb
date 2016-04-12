require File.dirname(__FILE__) + '/../test_helper'

class BookTest < ActiveSupport::TestCase
  fixtures :authors, :publishers, :books, :authors_books

  test "failing_create" do
    book = Book.new
    assert_equal false, book.save
    assert_equal 8, book.errors.count
    assert book.errors[:title]
    assert book.errors[:publisher]
    assert book.errors[:authors]
    assert book.errors[:published_at]
    assert book.errors[:isbn]
    assert book.errors[:blurb]
    assert book.errors[:page_count]
    assert book.errors[:price]
  end

  test "create" do
    book = Book.new(
      :title => 'Ruby on Rails',
      :authors => Author.all,
      :publisher_id => Publisher.find(1).id,
      :published_at => Time.now,
      :isbn => '123-123-123-1',
      :blurb => 'A great book',
      :page_count => 375,
      :price => 45.5
    )
  assert book.save
  end

  test "has_many_and_belongs_to_mapping" do
    apress = Publisher.find_by_name("Apress");
    count = apress.books.count
    book = Book.new(
      :title => 'Pro Rails E-Commerce 8th Edition',
      :authors => [Author.find_by_first_name_and_last_name('Joel', 'Spolsky'),
                   Author.find_by_first_name_and_last_name('Jeremy', 'Keith')],
      :publisher_id => apress.id,
      :published_at => Time.now,
      :isbn => '123-123-123-x',
      :blurb => 'E-Commerce on Rails',
      :page_count => 400,
      :price => 55.5
    )
    apress.books << book
    apress.reload
    book.reload
    assert_equal count + 1, apress.books.count
    assert_equal 'Apress', book.publisher.name
  end

  test "has_many_and_belongs_to_many_authors_mapping" do
    book = Book.new(
      :title => 'Pro Rails E-Commerce 8th Edition',
      :authors => [Author.find_by_first_name_and_last_name('Joel', 'Spolsky'),
                   Author.find_by_first_name_and_last_name('Jeremy', 'Keith')],
      :publisher_id => Publisher.find_by_name("Apress").id,
      :published_at => Time.now,
      :isbn => '123-123-123-x',
      :blurb => 'E-Commerce on Rails',
      :page_count => 400,
      :price => 55.5
    )
    assert book.save
    book.reload
    assert_equal 2, book.authors.count
    assert_equal 2, Author.find_by_first_name_and_last_name('Joel', 'Spolsky').books.count
  end
end
