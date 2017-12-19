class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @amount = params[:amount] ||= 0
  end

  def create
    amount = params[:amount].to_i
    token  = params[:stripeToken]
    payment_info = current_user.make_a_payment_with_stripe(amount, {token: token} )
    @payment =  Payment.new(payment_info)
    if @payment.save
      #flash message > Processed payment OR failed payment possible
    else
      #No flash here ? something went very wrong...
    end
    redirect_to current_user
  end

end
