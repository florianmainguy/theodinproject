class BookingsController < ApplicationController
  
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new
  	params[:passengers].to_i.times { @booking.passengers.build }
  end
  
  def create
  	@booking = Booking.new(booking_params)
  	if @booking.save
  		redirect_to booking_path(@booking)
      flash[:success] = "Flight has been successfully booked."
      
      @booking.passengers.each do |p|
        PassengerMailer.thanks_email(p).deliver
      end
  
  	else
      @flight = Flight.find(params[:flight_id])
  	  render 'new'
  	end
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  private
  
    def booking_params
      params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name, :email])
    end
end
