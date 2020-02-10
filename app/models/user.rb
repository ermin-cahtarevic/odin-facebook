class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[facebook]

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name = auth.info.name.split(' ')[1]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
