class FlightsController < ApplicationController
  
  def index
    @airports = Airport.all.map {|u| [u.name, u.id]}
    @dates = Flight.all.map {|u| [u.start_time, u.id]}
    @passengers = [1,2,3,4]
    
    
  end
end
