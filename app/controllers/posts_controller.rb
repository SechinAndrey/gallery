class PostsController < ApplicationController
  before_action :only_sign_in, only: [:new, :create]

  # caches_action :index, :cache_path => Proc.new {|c| c.request.url }


  def index
    @search = Post.search("")

    if params[:tag]
      @posts = Kaminari.paginate_array(Post.tagged_with(params[:tag]).order('created_at DESC')).page(params[:page]).per(5) # Post.order('created_at DESC').page(params[:page]).per(10)
    else
      @posts = Kaminari.paginate_array(@search.result.order('created_at DESC')).page(params[:page]).per(5) #@search.result.order('created_at DESC').limit(10).page(params[:page])
      if !params[:q].nil?
        @posts = Kaminari.paginate_array(@search.result.tagged_with(params[:q][:topik_cont], :any => true).order('created_at DESC')).page(params[:page]).per(5) # @search.result.tagged_with(params[:q][:topik_cont], :any => true).order('created_at DESC').page(params[:page]).per(10)
      end
    end

    @tags = Post.tag_counts_on(:tags).most_used(20)
  end

  def show
    @post = Post.find(params[:id])
    @comments = Kaminari.paginate_array(Comment.order('created_at DESC')).page(params[:page]).per(5) #Comment.order('created_at DESC').page(params[:page]).per(10)
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