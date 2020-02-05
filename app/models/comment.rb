class Comment < ApplicationRecord
  validates :comment_text, presence: true, length: { maximum: 150 }
  belongs_to :user
  belongs_to :post
end
