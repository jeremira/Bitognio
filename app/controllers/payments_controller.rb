class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    amount = 3000
    payment = current_user.payments.build
    payment.process_stripe_charge(amount, params[:stripeEmail], params[:stripeToken])
    #handle flash message depending of payment:message
    redirect_to current_user
  end

end
