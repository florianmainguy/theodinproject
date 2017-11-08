class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader

  before_save { self.email = email.downcase }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(user_name) 
    if user_name
      where('first_name ILIKE ? or last_name ILIKE ?', "%#{user_name}%", "%#{user_name}%")
    else
      all
    end
  end

  def self.search_by_full_name(names) 
    where('first_name ILIKE ? and last_name ILIKE ?', "%#{names[0]}%", "%#{names[1]}%")
  end
end
