class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = User.first
    
    if @comment.save
      @comment.post = @post # adding this here to cover when the comment cannot be saved due to being empty.  Otherwise, shows a blank comment at the bottom of the list of comments.
      @comment.save
      flash[:notice] = "Comment successfully added!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end