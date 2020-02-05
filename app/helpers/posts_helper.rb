module PostsHelper
  def liked?(post)
    post.likes.find { |like| like.user_id == current_user.id }
  end

  def comment_author(comment)
    comment.user == current_user
  end
end
