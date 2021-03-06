class CommentsController < ApplicationController

  def create
    if user_signed_in?
      @comment = current_user.comments.build(comment_params)
      @comment.save
      post_comment = Comment.where(post_id: @comment.post.id).order('created_at DESC')
      @page = params[:comment][:page]

      if post_comment.length > 10 && @page == ''
        @page = 1
      end

      if @page != ''
        index = (@page.to_i - 1) * 10
        @comment = post_comment[index.to_i]
      end

      if post_comment.length/10 + 1 == @page.to_i
        @page = ''
      end

      respond_to do |format|
        format.html { post_path(@comment.post.id) }
        format.js
      end

    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @page = params[:page] || 1
    @comment_last = nil

    if user_signed_in? && current_user.id == @comment.user.id
      @comment.destroy
      post_comment = Comment.where(post_id: @comment.post.id).order('created_at DESC')

      if post_comment.length >= 10
        @comment_last = post_comment[(@page.to_i) * 10 - 1]
      end

      respond_to do |format|
        format.js
      end
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :content, :user_id)
  end

end