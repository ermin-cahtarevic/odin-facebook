module FriendshipsHelper

  def friend_list
    @friend_list = current_user.friendships.map { |friendship| friendship.reciever if friendship.status }
    @friend_list += current_user.inverse_friendships.map { |friendship| friendship.sender if friendship.status }
    @friend_list << current_user
    @friend_list.compact
  end

  def friend?(user)
    friend_list.include?(user)
  end
end
