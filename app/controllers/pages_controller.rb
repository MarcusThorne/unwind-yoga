class PagesController < ApplicationController
  def home
    @events = Event.all
    @reviews = Review.all
  end

  def new_to_unwind
    @events = Event.all
  end

  def cleanliness
  end

  def studio
  end

  def resources
  end

  def rules
  end
end
