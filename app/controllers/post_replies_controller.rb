class PostRepliesController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

  def index
    @post = Post.find(params[:post_id])
    @replies = @post.replies
  end

  def show
    @reply = @post.replies.find(params[:id])
  end

  def new
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build
  end

  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.create(reply_params)
    @reply.user_id = current_user.id if current_user
    if @reply.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def reply_params
    params.require(:reply).permit(:content, :user_id)
  end

end
