class ForumsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_forum, :only => [:show, :edit, :update, :destroy, :join, :leave, :fake_delete]

  def index
    @forums = Forum.all.where("status != ?", "deleted")
  end

  def show
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new forum_params
    @forum.status = "private"
    @forum.creater_id = current_user.id
    @forum.users << current_user
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

  def join
    unless @forum.users.include? current_user
      @forum.users << current_user
      flash[:notice] = "加入成功"
    end
    redirect_to forum_posts_path(@forum)
  end

  def leave
    if @forum.users.include? current_user
      @forum.users.delete current_user
      flash[:notice] = "退出成功"
    else
      flash[:alert] = "退出fail"
    end
    redirect_to forum_posts_path(@forum)
  end

  def fake_delete
    @forum.status = "deleted"
    @forum.posts.each do |post|
      post.status = "deleted"
      post.save
    end
    @forum.save
    flash[:notice] = "此看板及其文章皆刪除"
    redirect_to forums_path
  end

  def destroy
    @forum.posts.destroy_all
    @forum.destroy
    flash[:notice] = "此看板及其文章皆刪除 absolutely"
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
