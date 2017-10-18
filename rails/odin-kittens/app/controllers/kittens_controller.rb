class KittensController < ApplicationController
  
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json {render :json => @kittens}
    end
  end
  
  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render :json => @kitten}
    end
  end
  
  def new
    @kitten = Kitten.new
  end
  
  def edit
    @kitten = Kitten.find(params[:id])
  end
  
  def create
    @kitten = Kitten.new(kitten_params)
  	if @kitten.save
      flash[:success] = "Kitten has been successfully created."
      redirect_to @kitten
  	else
  	  render 'new'
  	end
  end
  
  def update
    @kitten = Kitten.find(params[:id])
    @kitten.update(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten has been successfully edited."
      redirect_to @kitten
  	else
  	  render 'edit'
  	end
  end
  
  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = "Kitten deleted"
    redirect_to root_url
  end
  
  private
  
    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
