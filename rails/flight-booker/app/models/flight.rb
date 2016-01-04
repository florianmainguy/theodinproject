class Flight < ActiveRecord::Base
  belongs_to :start_airport, class_name: "Airport"
  belongs_to :stop_airport, class_name: "Airport"
  has_many :bookings
  
  def self.date_list
		dates = Flight.all.order(start_time: :asc)
		dates.map {|n| n.start_time.strftime("%d/%m/%Y") }.uniq
	end
	
	def self.search(depart, destination, date)
		Flight.where(start_airport_id: depart, 
					       stop_airport_id: destination,
					       start_time: Flight.correct_date(date))
	end
	
	def self.correct_date(date)
	  unless date.nil?
		  date = date.to_date
		  date.beginning_of_day..date.end_of_day
		end
	end
end
