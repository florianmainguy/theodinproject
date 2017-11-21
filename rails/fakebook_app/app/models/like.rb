class Like < ApplicationRecord
  belongs_to :likeable
  belongs_to :user
end
