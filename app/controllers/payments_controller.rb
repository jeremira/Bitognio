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
    if payment_info[:payment_processed] #Update account balance if Payment was done OK
      current_user.account.update_balance amount
    end
    
    @payment =  Payment.new(payment_info)
    if @payment.save
      flash[:notice] = 'Balance : ' + current_user.account.balance.to_s
    else
      #No flash here ? something went very wrong...
    end
    redirect_to current_user
  end

end
