class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @balance = current_user.account.balance
    if current_user.is_a_teacher
      render 'teacher_index'
    else
      render 'student_index'
    end
  end

  def new
    @amount = params[:amount] ||= 0
  end

  def create
    amount = params[:amount].to_i
    token  = params[:stripeToken]
    @payment =  current_user.make_a_payment_with_stripe(amount, {token: token} )
    if @payment.payment_processed
      flash[:notice] = 'Payment successful !'
    else
      flash[:alert] = "Payment could not be processed"
    end
    redirect_to payments_path
  end

end
