class ForumsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find_forum => [:show, :edit, :update]

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
  end

  protected

  def find_forum
    @forum = Forum.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:name)
  end

end
