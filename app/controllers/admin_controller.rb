class AdminController < ApplicationController
  def home
    
    if current_user.try(:admin?) == false
      redirect_to :root_path
    end
    
      @events = Event.all
      @sessions = Session.where(when: (DateTime.current + 1.hour..DateTime.current + 7.days))
  end

  def schedule
    @events = Event.all
  end
end
