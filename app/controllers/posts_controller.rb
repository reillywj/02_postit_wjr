class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_new_comment, only: [:show]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator_to_edit, only: [:edit, :update]

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

  def vote
    @vote = Vote.new(vote: params[:vote], creator: current_user, voteable: @post)

    if @vote.save
      flash[:notice] = "You voted for #{@post.title}."
    else
      flash[:errors] = "You have already voted for that."
    end
    redirect_to :back
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

  def require_creator_to_edit
    unless current_user_is_creator?(@post)
      flash[:errors] = "You can't do that."
      redirect_to post_path(@post)
    end
  end
end
