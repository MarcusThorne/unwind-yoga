class SessionsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @session = Session.new
  end

  def create
    # find event in params
    @event = Event.find(params[:event_id])
    if params[:weekly]
      # weeks equals number of days between when and until devided by 7
      weeks = (params[:until].to_date - params[:session][:when].to_date).to_i / 7
      while weeks > -1
        # create a new session with private session_params
        @session = Session.new(session_params)
        # Session id equals current event id
        @session.event_id = @event.id
        # Each session has a date of the first date set (when) plus the amount of weeks left in weeks array
        @session.when = params[:session][:when].to_date + weeks.week
        @session.save
        weeks -= 1
      end
      redirect_to @event
    else
      # do this if weekly isnt selected
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
