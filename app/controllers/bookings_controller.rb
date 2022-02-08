class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sessions = Session.where(when: (DateTime.current + 1.hour..DateTime.current + 7.days))
  end

  def new
    @event = Event.find(params['event_id'])
    @session = Session.find(params['session_id'])
    @booking = Booking.new

    # Checking to see capacity for specific date and time at the studio
    @studio_capacity = 6
    @session.bookings.where(presence: "studio").each do |booking|
      @studio_capacity -= booking['attendees'].to_i
    end

    @online_capacity = 100 - @session.bookings.where(presence: "online").length

    @presence_options = []
    if current_user.admin
      @presence_options << ["Coming to the studio", "studio"]
    else
      if @studio_capacity > 0
        @presence_options << ["Coming to the studio", "studio"]
      end
      if @online_capacity > 0
        @presence_options << ["Dialing in", "online"]
      end
    end

    @payment_options = []
    if current_user.admin
      @payment_options << ["When I get there", "cash"]
    else
      if @studio_capacity > 0
        @payment_options << ["Now", "online"]
      end
      if @online_capacity > 0
        @payment_options << ["When I get there", "cash"]
      end
    end

  end

  def create_payment_intent
    Stripe.api_key = ENV['STRIPE_SK']

    puts params

    case params[:presence]
    when "studio"
      price = 1500 * params[:attendees].to_i
    when "online"
      price = 1000 * params[:attendees].to_i
    end

    payment_intent = Stripe::PaymentIntent.create(
      amount: price,
      currency: 'usd'
    )

    render json: {
      id: payment_intent['id'],
      client_secret: payment_intent['client_secret']
    }

  end

  def create
    @event = Event.find(params[:event_id])
    @session = Session.find(params[:session_id])

    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.session_id = @session.id

    if @booking.save
      redirect_to [@event, @session, @booking]
    else
      render :new
    end
  end

  def show
    @event = Event.find(params['event_id'])
    @session = Session.find(params['session_id'])
    @booking = Booking.find(params['id'])

    if @booking.user_id != current_user.id
      redirect_to root_path
    end
  end

  def destroy
    @event = Event.find(params['event_id'])
    @session = Session.find(params['session_id'])
    @booking = Booking.find(params['id'])

    if current_user.id == @booking.user_id || current_user.admin

      if @booking.destroy

        if current_user.admin
          redirect_to bookings_path
        else
          redirect_to edit_registration_path(current_user)
        end

      else
        render :show

      end
    end

  end

  private

  def booking_params
    params.require(:booking).permit(:presence, :attendees, :payment_method, :payment_intent)
  end
end
