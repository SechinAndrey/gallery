class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    # if
    @comment.save

      respond_to do |format|
        format.html { post_path(@comment.post.id) }
        format.js
      end
    # else
    #   p "2" *100
    #   @comment.errors.full_messages.each do |msg|
    #     p "********************************  " + msg
    #     flash[:alert] = msg
    #     redirect_to root_path
    #     p "3"*100
    #   end
    #
    # end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.post.id
    @comment.destroy
    respond_to do |format|
      format.js
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :content, :user_id)
  end

end