class ForumPostsController < ApplicationController
  
  before_action :find_forum, :only => [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @posts = @forum.posts
  end

  def show
    @post = @forum.posts.find(params[:id])
  end

  def new
    @post = @forum.posts.new
  end

  def create
    @post = @forum.posts.build post_params
    @post.user_id = (session[:user_id] || 1)
    if @post.save
      #redirect_to post_path(@post)
      redirect_to forum_post_path(@post)
      #redirect_to forum_post_path(@forum, @post)
    else
      render new_forum_post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    #@post = @forum.posts.find(params[:id])
    if @post.update post_params
      redirect_to forum_post_path(@post)
    else
      render edit_forum_post_path(@post)
    end
  end

  def destroy
    @post = @forum.posts.find(params[:id])
    @post.destroy
    redirect_to forum_posts_path
  end

  protected

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :status, :forum_id, :tag_ids => [])
  end
end
