class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :cover, CoverUploader
  mount_uploader :picture, PictureUploader
 
  before_save { self.email = email.downcase }

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(user_name) 
    if user_name
      where('first_name ILIKE ? or last_name ILIKE ?', "%#{user_name}%", "%#{user_name}%")
    else
      User.all
    end
  end

  def self.search_by_full_name(names) 
    where('first_name ILIKE ? and last_name ILIKE ?', "%#{names[0]}%", "%#{names[1]}%")
  end

  def pending_requests
    FriendRequest.where(friend_id: self.id)
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
  end

  def remove_request(friend)
    self.friend_requests.destroy(friend)
  end

  def is_friend_with?(user)
    self.friends.exists?(user.id)
  end

  def has_asked_to_be_friend_with?(user)
    self.pending_friends.exists?(user.id)
  end

  def feed_posts
    Post.includes(:user)
        .where(:user_id => self.friends.pluck(:id) << self.id)
        .order(:created_at => :desc)
        .limit(15)
  end
end
