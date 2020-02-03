class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.save
      flash[:success] = 'Comment added'
      redirect_to post_path(@post)
    else
      flash[:danger] = 'Successfully failed!'
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment_text, :post_id)
    end
end
