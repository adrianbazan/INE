class Admin::ProducerController < ApplicationController
  def new
    @producer = Producer.new
    @page_title = 'Crear productora'
  end

  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      flash[:notice] = "Productora #{@producer.name} correctamente creada."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear productora'
      render :action => 'new'
    end
  end

  def edit
    @producer = Producer.find(params[:id])
    @page_title = 'Editar productora'
  end

  def update
    @producer = Producer.find(params[:id])
    if @producer.update_attributes(producer_params)
      flash[:notice] = "Productora #{@producer.name} correctamente actuaizada."
      redirect_to :action => 'show', :id => @producer
    else
      @page_title = 'Editar productora'
      render :action => 'edit'
    end
  end

  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = "Productora #{@producer.name} correctamente eliminada."
    redirect_to :action => 'index'
  end

  def show
    @producer = Producer.find(params[:id])
    @page_title = @producer.name
  end

  def index
    @producers = Producer.all
    @page_title = 'Mostrando productoras'
  end

  private
    def producer_params
      params.require(:producer).permit(:name)
    end
end
