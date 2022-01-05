class BookingMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking = booking
    @session = Session.find(@booking.session_id)
    @event = Event.find(@session.event_id)

    @user = @booking.user

    @zoom_link = @session.zoom_link
    @zoom_code = @session.zoom_code

    mail to: @booking.user.email, subject: "#{@event.name} Booking"
  end

  def booking_cancellation(booking, refunded)
    @booking = booking
    @user = @booking.user
    @refunded = refunded
    @session = Session.find(@booking.session_id)
    @event = Event.find(@session.event_id)

    mail to: @booking.user.email, subject: "Cancelled: #{@event.name} Booking"
  end
end
