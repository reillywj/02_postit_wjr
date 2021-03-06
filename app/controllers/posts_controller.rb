class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_new_comment, only: [:show]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator_or_admin_to_edit, only: [:edit, :update]

  def index
    @posts = Post.all.sort do |x, y|
      unless (y.total_votes <=> x.total_votes) == 0
        y.total_votes <=> x.total_votes
      else
        y.created_at <=> x.created_at
      end
    end
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
      respond_to do |format|
        flash[:notice] = "Your vote was counted."
        format.html { redirect_to :back}
        format.js
      end
    else
      flash[:errors] = "You have already voted for that."
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def set_new_comment
    @comment = Comment.new
    @comment.creator = User.first
  end

  def require_creator_to_edit
    unless current_user_is_creator?(@post)
      you_cant_do_that
    end
  end

  def require_creator_or_admin_to_edit
    unless current_user_is_creator?(@post) || current_user_is_admin?
      you_cant_do_that
    end
  end

  def you_cant_do_that
    flash[:errors] = "You can't do that."
    redirect_to post_path(@post)
  end

end
