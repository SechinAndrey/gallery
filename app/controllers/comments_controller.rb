class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)

    # if
    @comment.save
    respond_to do |format|
      format.html { post_path(@comment.post.id) }
      format.js
    end
    # end
      # redirect_to post_path(@comment.post.id)
    # else
    #   @comment.errors.full_messages.each do |msg|
    #   flash[:alert] = msg
    #   end
    #   redirect_to post_path(@comment.post.id)
    # end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.post.id
    @comment.destroy
    redirect_to post_path(post_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :content, :user_id)
  end

end