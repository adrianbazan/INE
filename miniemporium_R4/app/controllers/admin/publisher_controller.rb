class Admin::PublisherController < Admin::AuthenticatedController
  def new
    @publisher = Publisher.new
    @page_title = 'Create new publisher'
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      flash[:notice] = "Publisher #{@publisher.name} was succesfully created."
      redirect_to :action => 'index'
    else
      @page_title = 'Create new publisher'
      render :action => 'new'
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
    @page_title = 'Edit publisher'
  end

  def update
    @publisher = Publisher.find(params[:id])
    if @publisher.update_attributes(publisher_params)
       flash[:notice] = "Publisher #{@publisher.name} was succesfully updated."
       redirect_to :action => 'show', :id => @publisher
    else
       @page_title = 'Edit publisher'
       render :action => 'edit'
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy
    flash[:notice] = "Succesfully deleted publisher #{@publisher.name}."
    redirect_to :action => 'index'
  end

  def show
    @publisher = Publisher.find(params[:id])
    @page_title = @publisher.name
  end

  def index
    @publishers = Publisher.all
    @page_title = 'Listing publishers'
  end

  private
    def publisher_params
      params.require(:publisher).permit(:name)
    end
end
