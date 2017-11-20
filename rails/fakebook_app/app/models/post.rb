class Post < ApplicationRecord
  belongs_to: :user

  validates :body, :length => { minimum: 1 }
end
