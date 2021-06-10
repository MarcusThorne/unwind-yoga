class EventsController < ApplicationController

  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
  end

  def new
    if current_user.try(:admin?)
      @events = Event.all
      @event = Event.new
      render :index
    else
      redirect_to events_path
    end
  end

  def create
    if current_user.try(:admin?)
      @event = Event.new(event_params)
      @event.sessions.build
      if @event.save
        redirect_to events_path
      else
        render :new
      end
    else
      redirect_to events_path
    end
  end

  def edit
    if current_user.try(:admin?)
      @events = Event.all
      @event = Event.find(params[:id])
      render :index
    else
      redirect_to events_path
    end
  end

  def update
    if current_user.try(:admin?)
      @event = Event.find(params[:id])
      if @event.update(event_params)
        redirect_to events_path
      else
        render :edit
      end
    else
      redirect_to events_path
    end
  end

  def destroy
    if current_user.try(:admin?)
      @event = Event.find(params[:id])
      @event.destroy
    end
    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :photo)
  end
end