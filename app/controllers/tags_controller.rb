class TagsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :posts]
  before_action :find_tag, :only => [:show, :edit, :update, :destroy, :posts]

  def index
    @tags = Tag.all
    post_tagships = PostTagship.all
    @hits_of_each_tag = {}

    post_tagships.each do |ship|
      if @hits_of_each_tag.has_key? ship.tag_id
        @hits_of_each_tag[ship.tag_id] += 1
      else
        @hits_of_each_tag[ship.tag_id] = 1
      end
    end
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params

    begin
      @tag.save
    rescue ActiveRecord::RecordNotUnique => e
      flash[:alert] = " #{@tag.name} 早就有囉, 換一個吧 :)"
    end
    redirect_to tags_path
    #if @tag.save
    #  flash[:notice] = "新增標籤成功"
    #  redirect_to tags_path
    #else
    #  flash[:alert] = "新增標籤失敗"
    #  render :new
    #end
  end

  def edit
  end

  def update
    if @tag.update tag_params
      flash[:notice] = "編輯標籤成功"
      redirect_to tag_posts_path(@tag)
    else
      flash[:alert] = "編輯標籤失敗"
      render :edit
    end
  end

  def destroy
    PostTagship.where(:tag_id => @tag).delete_all
    @tag.destroy
    flash[:notice] = "刪除標籤成功"
    redirect_to tags_path
  end

  def posts
    @posts = @tag.posts.where("status = ? OR status != ? AND user_id = ? ", "public", "deleted", session[:user_id]).order("updated_at DESC")
    render :posts_tag
  end

  # with routes get 'tags/posts_of_this_tag'
  #def posts_of_this_tag
  #  @tag = Tag.find(params[:tag_id])
  #  @posts = @tag.posts.where("status = ? OR status != ? AND user_id = ? ", "public", "deleted", session[:user_id]).order("updated_at DESC")
  #  render :posts_of_this_tag
  #end

  def hot_tag
  end

  protected

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end
