class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = User.first
    if @comment.save
      @comment.post = @post
      @comment.save
      flash[:notice] = "Comment successfully added!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def show
    flash[:notice] = "You went through the Comments show action!!!"
    @post = Comment.find(params[:id]).post
    redirect_to post_path(@post)
  end



end