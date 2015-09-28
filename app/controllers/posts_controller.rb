class PostsController < ApplicationController
  before_action :only_sign_in, only: [:new, :create]

  # caches_action :index, :cache_path => Proc.new {|c| c.request.url }


  def index
    @search = Post.search("")

    if params[:tag]
      @posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC').tagged_with(params[:tag])
    else
      @posts = @search.result.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
      if !params[:q].nil?
        @posts = @search.result.tagged_with(params[:q][:topik_cont], :any => true).paginate(:page => params[:page], :per_page => 10)
      end
    end

    @tags = Post.tag_counts_on(:tags).most_used(20)
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.paginate(:page => params[:page], :per_page => 10).where(post_id: params[:id]).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    # expire_action action: 'index'
    @post = current_user.posts.build(post_params)
    if @post.save
      @post_event = PostEvent.new(user_id: current_user.id, username: current_user.username, post_id: @post.id, post_name: @post.topik, action: "Create post")
      @post_event.save
      redirect_to root_path
    else
      @post.errors.full_messages.each do |msg|
      flash[:alert] =  msg
      end
      redirect_to new_post_path
    end
  end

  def edit

  end

  def destroy
    # expire_action action: 'index'
    @post = Post.find(params[:id])
    @post_event = PostEvent.new(user_id: current_user.id, username: current_user.username, post_id: @post.id, post_name: @post.topik, action: "Delete post")
    if user_signed_in? && current_user.id == @post.user.id
      if @post.destroy
        @post_event.save
        redirect_to root_path
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:topik, :content, :user_id, :tag_list)
  end

end