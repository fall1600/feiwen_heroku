class ForumsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_forum, :only => [:show, :edit, :update, :destroy, :join, :leave, :cancel, :fake_delete, :check_joi, :kick_out]

  def index
    @forums = Forum.all.where("status != ?", "deleted")
  end

  def show
    @joined_users = []
    @pending_users = []
    @bucketed_users = []

    ships = ForumUsership.where("forum_id = ?", @forum)
    ships.each do |ship|
      case ship.status
      when "joined"
        @joined_users << User.find_by(:id => ship.user_id)
      when "pending"
        @pending_users << User.find_by(:id => ship.user_id)
      when "bucketed"
        @bucketed_users << User.find_by(:id => ship.user_id)
      end
    end
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
      find_ship_of_forum_and_current_user
      @ship.status = "hosting"
      @ship.save
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

  def check_join
    ships = ForumUsership.where("status = ?", "pending").find_by_forum_id(@forum)
    redirect_to :check_join_forum
  end

  def join
    unless @forum.users.include? current_user
      @forum.users << current_user
    end
    find_ship_of_forum_and_current_user
    @ship.status = "pending"
    @ship.save
    flash[:notice] = "加入成功"
    redirect_to forum_posts_path(@forum)
  end

  def leave
    if @forum.users.include? current_user
      find_ship_of_forum_and_current_user
      @ship.status = "left"
      @ship.save
      #@forum.users.delete current_user
      # not really deleted :)
      flash[:notice] = "退出成功"
    else
      flash[:alert] = "退出fail"
    end
    redirect_to forum_posts_path(@forum)
  end

  def cancel
    if @forum.users.include? current_user
      @forum.users.delete current_user
    end
    flash[:notice] = "取消申請"
    redirect_to forums_path(@forum)
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

  def bucket
    set_ship_status "bucketed"
  end

  def confirm_join
    set_ship_status "joined"
  end

  def pend
    set_ship_status "pending"
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
    params.require(:forum).permit(:name, :user_ids=>[])
  end

  def find_ship_of_forum_and_current_user
    @ship = ForumUsership.find_by_forum_id_and_user_id(@forum, current_user)
  end

  def set_ship_status status
    user = User.find(params[:id])
    forum = Forum.find(params[:forum_id])
    ship = ForumUsership.find_by_forum_id_and_user_id(forum, user)
    ship.status = status
    if ship.save
      redirect_to forum
    end
  end

end
