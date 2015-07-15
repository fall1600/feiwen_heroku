class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to :root
    else 
      render :new
    end
  end

  def edit
  end

  def update
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :about, :password, :password_confirmation)
  end

end
