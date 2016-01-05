class KittensController < ApplicationController
  
  def index
    @kittens = Kitten.all
  end
  
  def show
    @kitten = Kitten.find(params[:id])
  end
  
  def new
    @kitten = Kitten.new
  end
  
  def edit
  end
  
  def create
    @kitten = Kitten.new(kitten_params)
  	if @kitten.save
  		redirect_to @kitten
      flash[:success] = "Kitten has been successfully created."
  	else
  	  render 'new'
  	end
  end
  
  def update
    @kitten.update(kitten_params)
    if @kitten.save
  		redirect_to @kitten
      flash[:success] = "Kitten has been successfully edited."
  	else
  	  render 'edit'
  	end
  end
  
  private
  
    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
