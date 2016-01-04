class FlightsController < ApplicationController
  
  def index
    @airports = Airport.all.map {|u| [u.name, u.id]}
    @dates = Flight.date_list
    @nb_passengers = [1,2,3,4]

		@departure_airport = params[:from]
		@arrival_airport = params[:to]
		@date = params[:departure_date]
		@pas = params[:passengers]
		
		@flights = Flight.search(@departure_airport,
								 		         @arrival_airport,
								 		         @date)
		 	
		if params[:commit] == "Search"
			if params[:from] == params[:to]
				flash.now[:danger] = "Your Departure and Destination Airports Can Not Be the Same"
			elsif @flights.empty?
			  flash.now[:danger] = "No Flight for Selected Date"
			end
		end
  end
end
