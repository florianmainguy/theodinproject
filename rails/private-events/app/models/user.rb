class User < ActiveRecord::Base
  has_many :created_events, :foreign_key => 'creator_id', :class_name => 'Event'
  has_many :attended_events, :through => :user_events, :source => :event
  has_many :user_events
  
  def upcoming_events
    events = []
    self.attended_events.each do |event|
      if event.date > Time.now
        events << event
      end
    end
    events
  end

  def previous_events
    events = []
    self.attended_events.each do |event|
      if event.date < Time.now
        events >> event
      end
    end
    events
  end
end
