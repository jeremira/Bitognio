class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @balance = current_user.account.balance
  end

  def new
    @amount = params[:amount] ||= 0
  end

  def create
    amount = params[:amount].to_i
    token  = params[:stripeToken]

    #process payment and update user balance
    payment_info = current_user.make_a_payment_with_stripe(amount, {token: token} )

    @payment =  Payment.new(payment_info)
    if @payment.save
      if @payment.payment_processed
        flash[:notice] = 'Payment successful !'
      else
        flash[:alert] = "Payment could not be processed"
      end
    else
      #something went very wrong here, should not happen
      flash[:alert] = "Payment record could not be saved."
    end
    redirect_to payments_path
  end

end
