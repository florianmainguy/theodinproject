class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :likers, dependent: :destroy, through: :likes
  has_many :comments, dependent: :destroy

  validates :body, :length => { minimum: 1 }
end
