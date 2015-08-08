class ForumsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_forum, :only => [:show, :edit, :update, :destroy, :join_this]

  def index
    @forums = Forum.all
  end

  def show
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new forum_params
    if @forum.save
      flash[:notice] = "建立成功"
      redirect_to forums_path
    else
      flash[:alert] = "再試一次"
      render new_forum_path
    end
  end

  def edit
  end

  def update
    if @forum.update forum_params
      flash[:notice] = "看板編輯成功"
      redirect_to forum_posts_path(@forum)
    else
      flash[:alert] = "看板編輯失敗"
      render :edit
    end
  end

  def fake_delete
    @forum.status = "deleted"
    @forum.posts.each do |post|
      post.fake_delete
    end
    @forum.save
    redirect_to forums_path
  end

  def join_this
    @forum.users << current_user
    redirect_to forum_path(@forum)
  end

  def destroy
    @forum.posts.destroy_all
    @forum.destroy
    redirect_to forums_path
  end

  protected

  def find_forum
    @forum = Forum.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:name)
  end

end
