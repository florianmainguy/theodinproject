class SessionController < ApplicationController
  def new
    if current_user
      redirect_to current_user
    end
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user 
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid name'
      render 'new'
    end
  end

  def destroy
    log_out user
    redirect_to root
  end
end
