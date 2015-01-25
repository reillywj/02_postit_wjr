class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    # before_action set_post
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params) # My guess at create method
    @post.creator = User.first # TODO: change once we have authentication

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to post_path(@post)
    else
      render 'new'
    end

  end

  def edit
    # before_action set_post
  end

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
end
