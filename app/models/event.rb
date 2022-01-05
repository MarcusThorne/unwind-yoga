class Event < ApplicationRecord
  has_one_attached :photo
  has_many :sessions, dependent: :destroy
end
