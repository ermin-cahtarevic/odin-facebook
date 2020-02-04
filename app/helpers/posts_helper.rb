module PostsHelper
  def liked?(post)
    post.likes.find { |like| like.user_id == current_user.id }
  end
end
