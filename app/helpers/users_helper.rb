module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.first_name, class: 'gravatar')
  end

  def pending?(user)
    current_user.friendships.find_by(reciever_id: user.id)
  end

  def recieved?(user)
    current_user.inverse_friendships.find_by(sender_id: user.id, status: false)
  end

  def friends?(user)
    if Friendship.where(sender_id: user.id, reciever_id: current_user.id, status: true) ||
       Friendship.where(sender_id: current_user.id, reciever_id: user.id, status: true)
      return true
    end

    false
  end
end
