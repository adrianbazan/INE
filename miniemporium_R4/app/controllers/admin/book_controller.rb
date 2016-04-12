class Admin::BookController < Admin::AuthenticatedController
  def new
    load_data
    @book = Book.new
    @page_title = 'Create new book'
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book #{@book.title} was succesfully created."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Create new book'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @book = Book.find(params[:id])
    @page_title = 'Edit book'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:notice] = "Book #{@book.title} was succesfully updated."
      redirect_to :action => 'show', :id => @book
    else
      load_data
      @page_title = 'Edit book'
      render :action => 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Succesfully deleted book #{@book.title}."
    redirect_to :action => 'index'
  end

  def show
    @book = Book.find(params[:id])
    @page_title = @book.title
  end

  def index
    sort_by = params[:sort_by]
    @books = Book.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Listing books'
  end

  private

    def load_data
      @authors = Author.all
      @publishers = Publisher.all
    end

    def book_params
      params.require(:book).permit(:title, :publisher_id, :published_at, { :author_ids => [] },
                                   :isbn, :blurb, :price, :page_count, :cover_image)
    end
end
