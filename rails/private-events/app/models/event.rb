class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => 'user'
  has_many :attendees, :through => :user_events, :source => :user
  has_many :user_events
  
  scope :past,   lambda {where("date < ?", Time.now)}
  scope :future, lambda {where("date > ?", Time.now)}
end
