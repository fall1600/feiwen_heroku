class UserPostsController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    @posts = @user.posts.where("status = ? OR status = ? AND user_id = ?", "public", "private", session[:user_id]).order("updated_at DESC")

    #if @user.id == session[:user_id]
      # moved this sql clause to scope of post
      #@posts = @user.posts.where("status != ?", 'deleted').order("updated_at DESC")
     # @posts = Post.own_posts(@user)
    #else
      # moved this sql clause to scope of post
      #@posts = Post.where("user_id = ? AND status = ?", @user.id, 'public').order("updated_at DESC")
     # @posts = Post.others_posts(@user)
    #end
  end

  def show
  end

end
