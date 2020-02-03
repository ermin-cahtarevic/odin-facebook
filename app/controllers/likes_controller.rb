class LikesController < ApplicationController
  before_action :post_find
  before_action :like_find, only: [:destroy]
  
  def create
    @post.likes.build(user_id: current_user.id)
    redirect_to root_path
  end

  def destroy
    @like.destroy
    redirect_to root_path
  end

  private

  def post_find
    @post = Post.find(params[:post_id])
  end


  def like_find
    @like = @post.likes.find(params[:id])
  end
end