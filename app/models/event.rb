class Event < ApplicationRecord
  has_many :sessions, dependent: :destroy, inverse_of: :event
  accepts_nested_attributes_for :sessions
  has_one_attached :photo

  def find_color
    event_names = []
    Event.all.each do |event|
      event_names << event.name
    end
    event_names.uniq

    case self.name 
    when event_names[0]
      "bg-yellow text-black"
    when event_names[1]
      "bg-black text-white"
    when event_names[2]
      "bg-pink text-black"
    when event_names[3]
      "bg-blue text-black"
    when event_names[4]
      "bg-teal text-white"
    when event_names[5]
      "bg-white text-black"
    when event_names[6]
      "bg-gray text-white"
    when event_names[7]
      "bg-black text-white"
    when event_names[8]
      "bg-black text-white"
    end
  end
end
