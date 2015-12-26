class Airport < ActiveRecord::Base
  has_many :departing_flights, class_name: "Flight", foreign_key: "start_airport_id"
  has_many :arriving_flights, class_name: "Flight", foreign_key: "stop_airport_id"
end
