class LikesController < ApplicationController
  before_action :post_find
  before_action :like_find, only: [:destroy]

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to request.referrer
  end

  def destroy
    @like.destroy
    redirect_to request.referrer
  end

  private

  def post_find
    @post = Post.find(params[:post_id])
  end

  def like_find
    @like = @post.likes.find(params[:id])
  end
end
