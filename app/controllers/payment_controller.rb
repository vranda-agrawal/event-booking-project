class PaymentController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_event

  def create
    enrol_user
    @payment=create_payment(params["nonce"],@event.price.to_i)
    if @payment.success?
      if Transaction.create(transaction_id:@payment.data.payment[:id],user_id:current_user.id,status:@payment.data.payment[:status],token:params["card-nonce"],event_id:@event.id)
        redirect_to events_path
      else
        flash[:message]=["Something went wrong"]
        redirect_to events_path
      end
    else
      flash[:message]=["We couldn't process your transaction"]
      redirect_to events_path
    end
  end

  private

  def enrol_user
    if Enrol.create(user_id:current_user.id,event_id:params[:id])
      @event.delay.registration_sms(current_user)
      flash[:message]=["Successfully enrolled in an event"]
    else
      flash[:message]=["Successfully enrolled in an event"]
    end
  end

  def get_square_client
    access_token = "EAAAENVqfGK99lOtJzCAXunx8D4vSjPHps95HAE9hRtxhGVaAuoBeAt6R2kZY49P"
    location_id = "L529VGVNRVPCX"
    case Rails.env
    when"production"
      environment="production"
    else
      environment='sandbox'
    end
    client = Square::Client.new(
      access_token: access_token,
      environment: environment
    )
    return client
  end

  def create_payment(nonce, price)
    client=self.get_square_client
    location_id="L529VGVNRVPCX"
    result = client.payments.create_payment(
      body: {
        source_id: nonce,
        idempotency_key: SecureRandom.uuid(),
        amount_money: {
          amount: price,
          currency: "USD"
        },
        location_id: location_id
      }
    )
    return result
  end

  def set_event
    @event=Event.find(params[:id])
  end
end
