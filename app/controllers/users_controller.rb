class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "建立成功 #{@user.name}" 
      redirect_to :root
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])
    if @user.update user_params
      flash[:notice] = "修改成功 - #{@user.updated_at.to_formatted_s(:short)}"
      redirect_to @user
    else
      flash[:alert] = "修改失敗 :("
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :about, :password, :password_confirmation)
  end

end
