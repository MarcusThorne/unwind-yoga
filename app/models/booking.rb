Stripe.api_key = "sk_test_51HdlOnLkJDKu0sqLUjH16NgaAgeJbHULhiyk1m0TqGcWnZkGqmRlwMzjbe0JcECNiFW0wsB25YTpzj4ltrMnyr4a00fRX1gu92"

class Booking < ApplicationRecord

  belongs_to :session
  belongs_to :user

  before_validation :attendees
  validate :capacity
  validate :payment

  after_save :confirmation_email

  before_destroy :refund
  before_destroy :cancellation_email

  include PgSearch::Model
  pg_search_scope :search_by_id,
                  against:  [ :id ],
                  using: {
                    tsearch: { prefix: true }
                  }


  def capacity

    session = Session.find(session_id)

    case presence
    when "studio"
      current_attendees = 0
      session.bookings.where(presence: "studio").each do |booking|
        current_attendees += booking['attendees'].to_i
      end
      if attendees.to_i + current_attendees > 6
        errors.add(:base, "Sorry, we ran out of space while you were booking :(")
      end

    when "online"
      if attendees.to_i + session.bookings.where(presence: "online").length > 100
        errors.add(:base, "Sorry, we've run out of space :(")
      end
    end

  end

  def payment

    if self.presence == "online" && self.payment_method != "online"
      errors.add(:base, "If you're dialling in you need to pay now. Thanks!")
    end

    if self.payment_method == "online"
      
      intent = Stripe::PaymentIntent.retrieve(payment_intent)

      if intent.status != "succeeded"
        errors.add(:base, "Sorry, your payment didn't go through. Give it another go!")
      end

      if intent.status == "succeeded" && errors.any?
        Stripe::Refund.create({
          payment_intent: self.payment_intent
        })
      end
    
    end

  end

  def confirmation_email
    BookingMailer.booking_confirmation(self).deliver_now
  end

  def refund

    intent = Stripe::PaymentIntent.retrieve(payment_intent)

    if intent.status != "succeeded"
      
      if self.payment_method == "online" && Session.find(self.session_id).when.to_date > Date.today
        Stripe::Refund.create({
            payment_intent: self.payment_intent
          })
      end
    
    end
  
  end

  def cancellation_email
    
    if self.payment_method == "online" && Session.find(self.session_id).when.to_date > Date.today
      refunded = true
    end
    
    BookingMailer.booking_cancellation(self, refunded).deliver_now
  
  end

end