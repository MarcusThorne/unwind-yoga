class SessionsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @session = Session.new
  end

  def create
    @event = Event.find(params[:event_id])
    if params[:weekly]
      weeks =  (params[:until].to_date - params[:session][:when].to_date).to_i / 7
      while weeks > -1 do
        @session = Session.new(session_params)
        @session.event_id = @event.id
        @session.when = params[:session][:when].to_date + weeks.week
        @session.save
        weeks -= 1
      end
      redirect_to @event
    else
      @session = Session.new(session_params)
      @session.event_id = @event.id
      if @session.save
        redirect_to @event
      else
        render 'events/show'
      end
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @session = Session.find(params[:id])
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to events_path
  end

  private

  def session_params
    params.require(:session).permit(:when, :weekly, :until, :zoom_link, :zoom_code)
  end

end
