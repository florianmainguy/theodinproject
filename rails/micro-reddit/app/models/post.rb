class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 250 }
  validates :body, presence: true
  belongs_to :user
  has_many :comments
end
