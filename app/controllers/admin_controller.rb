class AdminController < ApplicationController
  def home
    # stops people from accessing admin page if the user.admin == false
    if current_user.try(:admin?) == false
      redirect_to :root_path
    end

    # showing sessions on admin hompage calendar
    @sessions = Session.where(when: (DateTime.current + 1.hour..DateTime.current + 7.days))
  end

  def schedule
    # showing all event sessions for calendar
    @events = Event.all
  end
end
