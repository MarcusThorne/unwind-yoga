class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def find_color(event)
    if event % 5 === 0
      "bg-yellow text-white"
    elsif event % 4 === 0
      "bg-teal text-white "
    elsif event % 3 === 0
      "bg-pink text-white"
    elsif event % 2 === 0
      "bg-blue text-white"
    else
      "bg-red text-white"
    end
  end
end
