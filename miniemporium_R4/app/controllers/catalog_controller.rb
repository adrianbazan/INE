class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => :show
  before_filter :require_no_user

  def show
    @book = Book.find(params[:id])
    @page_title = @book.title
  end

  def index
    @books = Book.order("books.id desc").includes(:authors, :publisher).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catalog'
  end

  def latest
    @books = Book.latest 5 # invoques "latest" method to get the five latest books
    @page_title = 'Latest books'
  end
end
