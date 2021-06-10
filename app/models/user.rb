class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :bookings

  include PgSearch::Model
  pg_search_scope :search_by_username,
                  against:  [ :id, ],
                  using: {
                    tsearch: { prefix: true }
                  }
end
