class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_new_comment, only: [:show]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by{|post| post[:created_at]}.reverse
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to post_path(@post)
    else
      render 'new'
    end

  end

  def edit; end

  def update
    # before_action set_post
    if @post.update(post_params)
      flash[:notice] = "\"#{@post.title}\" was updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_new_comment
    @comment = Comment.new
    @comment.creator = User.first
  end
end
