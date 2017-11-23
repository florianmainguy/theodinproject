class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: 'User', foreign_key: 'user_id'
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :likers, dependent: :destroy, through: :likes
end
