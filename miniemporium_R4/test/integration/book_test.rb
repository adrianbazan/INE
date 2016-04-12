require File.dirname(__FILE__) + '/../test_helper'

class BookTest < ActionDispatch::IntegrationTest

  test "book_aministration" do
    publisher = Publisher.create(:name => 'Books of Ruby')
    author = Author.create(:first_name => 'John', :last_name => 'Anderson')
    george = new_session_as(:george)

    new_book_ruby = george.add_book :book => {
      :title => 'A new Book of Ruby',
      :publisher_id => publisher.id,
      :author_ids => [author.id],
      :published_at => Time.now,
      :isbn => '123-123-123-X',
      :blurb => 'A new Book of Ruby',
      :page_count => 325,
      :price => 45.5
    }

    george.list_books
    george.show_book new_book_ruby

    george.edit_book new_book_ruby, :book => {
      :title => 'A very new Book of Ruby',
      :publisher_id => publisher.id,
      :author_ids => [author.id],
      :published_at => Time.now,
      :isbn => '123-123-123-X',
      :blurb => 'A very new Book of Ruby',
      :page_count => 350,
      :price => 50
    }

    bob = new_session_as(:bob)
    bob.delete_book new_book_ruby
  end

  private

  module BookTestDSL
    attr_writer :name

    def add_book(parameters)
      author = Author.first
      publisher = Publisher.first
      get '/admin/book/new'
      assert_response :success
      assert_template 'admin/book/new'
      assert_tag :tag => 'option', :attributes => { :value => publisher.id }
      assert_tag :tag => 'select', :attributes => { :name => 'book[author_ids][]' }
      post '/admin/book/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/book/index'
      page = Book.all.count / 5 + 1
      get "/admin/book/index/?page=#{page}"
      assert_tag :tag => 'td', :content => parameters[:book][:title]
      book = Book.find_by_title(parameters[:book][:title])
      return book;
    end

    def edit_book(book, parameters)
      get "admin/book/edit?id=#{book.id}"
      assert_response :success
      assert_template 'admin/book/edit'
      post "/admin/book/update?id=#{book.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/book/show'
    end

    def delete_book(book)
      post "/admin/book/destroy?id=#{book.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/book/index'
    end

    def show_book(book)
      get "/admin/book/show/#{book.id}"
      assert_response :success
      assert_template 'admin/book/show'
    end

    def list_books
      get 'admin/book/index'
      assert_response :success
      assert_template 'admin/book/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BookTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
