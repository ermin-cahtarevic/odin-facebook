class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, foreign_key: :sender_id
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :reciever_id

  def reject_request(sender)
    friendship = inverse_friendships.find { |f| f.sender == sender }
    friendship.destroy
  end

  def friend_with?(user)
    if inverse_friendships.find_by(sender_id: user.id,
                                   status: true) ||
       friendships.find_by(reciever_id: user.id, status: true)
      true
    end
  end
end
