class Admin::AuthorController < Admin::AuthenticatedController
  def new
    @author = Author.new
    @page_title = 'Create new author'
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:notice] = "Author #{@author.name} was succesfully created."
      redirect_to :action => 'index'
    else
      @page_title = 'Create new author'
      render :action => 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
    @page_title = 'Edit author'
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(author_params)
      flash[:notice] = "Author #{@author.name} was succesfully updated."
      redirect_to :action => 'show', :id => @author
    else
      @page_title = 'Edit author'
      render :action => 'edit'
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    flash[:notice] = "Succesfully deleted author #{@author.name}."
    redirect_to :action => 'index'
  end

  def show
    @author = Author.find(params[:id])
    @page_title = @author.name
  end

  def index
    @authors = Author.all
    @page_title = 'Listing authors'
  end

  private
    def author_params
      params.require(:author).permit(:first_name, :last_name)
    end
end
