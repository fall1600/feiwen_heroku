class ForumPostsController < ApplicationController
  
  before_action :find_forum, :only => [:index, :show, :new, :create]

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
    if @post.save
      redirect_to forum_posts_path
      #redirect_to forum_post_path(@forum, @post)
    else
      render new_forum_post_path(@post)
    end
  end

  protected

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :status, :forum_id, :tag_ids => [])
  end
end
