class ForumPostsController < ApplicationController
  
  before_action :authenticate_user!, :except => []
  before_action :find_forum, :only => [:index, :show, :new, :create, :edit, :update, :destroy, :fake_delete]

  def index
    ship = ForumUsership.find_by_forum_id_and_user_id(@forum, current_user)
    @ships = ForumUsership.where("status = ? and forum_id = ?", "pending", @forum )

    case ship.try(:status)
    when "hosting"
      @posts = @forum.posts
    when "joined"
      @posts = @forum.posts.where("status = ? OR status = ?", "forum", "public")
    when "pending"
      flash[:notice] = "you are pending, public posts only"
      @posts = @forum.posts.where("status = ?", "public")
    when "bucketed"
      flash[:alert] = "you are bucketed, no posts you can see"
      @posts = []
    else
      flash[:notice] = "join this forum :)"
      @posts = []
    end
  end

  def show
    @post = @forum.posts.find(params[:id])
  end

  def new
    @post = @forum.posts.new
  end

  def create
    @post = @forum.posts.new post_params
    @post.user_id = (session[:user_id] || 1)
    @post.status = "forum"
    if @post.save
      redirect_to forum_post_path(@forum, @post)
    else
      render new_forum_post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      #@post = Post.find(params[:id])
    if @post.update post_params
      redirect_to forum_post_path(@forum, @post)
    else
      render edit_forum_post_path(@forum, @post)
    end
  end

  def fake_delete
    @post = Post.find(params[:id])
    if @post.user_id == session[:user_id]
      @post.status = "deleted"
      @post.save
      flash[:notice] = "delete success"
      redirect_to forum_posts_path(@forum)
    else
      flash[:alert] = "you can't delete this post"
      redirect_to forum_posts_path(@forum)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to forum_posts_path(@forum)
  end

  protected

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :status, :forum_id, :tag_ids => [])
  end
end
