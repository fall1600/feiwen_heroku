class SessionsController < ApplicationController
  #POST /session

  def create
    user = User.find_by(email: params[:email])
    if user = user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      flash[:notice] = "歡迎回來! #{user.name}"
    else
      flash[:alert] = "登入失敗"
    end
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "登出"
    redirect_to root_path
  end
end
