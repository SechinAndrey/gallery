class PostsController < ApplicationController
  before_action :only_sign_in, only: [:new, :create]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.paginate(:page => params[:page], :per_page => 2).where(post_id: params[:id]).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
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

  private
  def post_params
    params.require(:post).permit(:topik, :content, :user_id)
  end

end