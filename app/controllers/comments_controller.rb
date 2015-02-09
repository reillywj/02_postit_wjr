class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    
    if @comment.save
      @comment.post = @post # adding this here to cover when the comment cannot be saved due to being empty.  Otherwise, shows a blank comment at the bottom of the list of comments.
      @comment.save
      flash[:notice] = "Comment successfully added!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.new(vote: params[:vote], voteable: @comment, creator: current_user)

    if @vote.save
      respond_to do |format|
        format.html {redirect_to :back, notice: "Your vote counted for that comment."}
        format.js
      end
    else
      flash[:errors] = "You already voted for that comment."
      redirect_to :back
    end
  end

end