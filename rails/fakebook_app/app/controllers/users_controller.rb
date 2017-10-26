class UsersController < ApplicationController
  def index
  end

  def new
    render html: "You really should sign in!"
  end
end
