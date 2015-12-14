class User < ActiveRecord::Base
  has_many :created_events, :foreign_key => 'creator_id', :class_name => 'Event'
  has_many :attended_events, :through => :user_events, :source => :event
  has_many :user_events
end
