class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
