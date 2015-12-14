class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = "New event created."
      redirect_to events_path
    else
      render "new"
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end
  
  private
  
    def event_params
      params.require(:event).permit(:date, :location, :description)
    end
end
