class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  before_save { self.email = email.downcase }

  #validates :first_name, presence: true, length: { maximum: 50 }
  #validates :last_name, presence: true, length: { maximum: 50 }

  def full_name
    "#{first_name} #{last_name}"
  end

end
