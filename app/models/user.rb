class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, foreign_key: :sender_id
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :reciever_id
  
  def friend_list
    friend_list = friendships.map { |friendship| friendship.reciever if friendship.status }
    friend_list + inverse_friendships.map { |friendship| friendship.sender if friendship.status }
    friend_list.compact
  end

  def sent_requests
    friendships.map { |friendship| friendship.reciever if !friendship.status }.compact
  end

  def recieved_requests
    inverse_friendships.map { |friendship| friendship.sender if !friendship.status }.compact
  end

  def confirm_request(sender)
    friendship = inverse_friendships.find { |friendship| friendship.sender == sender }
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friend_list.include?(user)
  end
end
