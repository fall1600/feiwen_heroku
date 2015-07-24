class PostTagsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :find_post, :only => [:new, :create]

  def new
    @tag = @post.tags.create
  end

  def create
    @tag = @post.tags.create tag_params
    if @tag.save
      redirect_to @post
    else
      render :new
    end
  end

  protected

  def find_post
    @post = Post.find(params[:post_id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end
