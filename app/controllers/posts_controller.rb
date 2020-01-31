class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :create, :edit, :update]

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to root_path
    else
      flash.now[:danger] = "Content can't be empty!"
      render 'new'
    end
  end

  def edit; end

  def update; end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def index
    if current_user
      @post = current_user.posts.build
    end
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
