class CommentsController < ApplicationController
  def new
    @comment = Comment.new

    render :new
  end

  def create
    comment = Comment.new(comment_params)
    comment.author = current_user

    comment.save

    redirect_to post_url(comment.post)
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def destroy
    comment = Comment.find(params[:id])

    comment.destroy

    redirect_to post_url(comment.post)
  end

  def upvote
    vote = Vote.new(user_id: current_user.id)
    comment = Comment.find(params[:id])
    vote.votable = comment
    vote.save

    redirect_to post_url(comment.post)
  end

  def downvote
    vote = Vote.new(user_id: current_user.id, upvote: false)
    comment = Comment.find(params[:id])
    vote.votable = comment
    vote.save

    redirect_to post_url(comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
