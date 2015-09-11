class PostsController < ApplicationController
  before_action :only_sign_in, only: [:new, :create]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    p current_user
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      #out errors
    end
  end

  def edit

  end

  private
  def post_params
    params.require(:post).permit(:topik, :content, :user_id)
  end

end