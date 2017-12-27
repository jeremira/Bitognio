class User < ApplicationRecord
  has_many :payments
  has_one  :account

  before_create :create_account_child
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def make_a_payment_with_stripe(amount, processing_information={})
    token = processing_information[:token]
    payment_processed = false
    error_message = nil
    amount = 0 unless amount.is_a? Integer

    if amount > 2999
      begin
        charge = Stripe::Charge.create(
          :amount => amount,
          :currency => "usd",
          :description => "Lesson charge",
          :source => token,
        )
      rescue Stripe::CardError => e
        error_message =  e.message
      rescue
        error_message =  "Internal Error : No token provided"
      else
        payment_processed = true
      end
    else
      error_message = "Amount too low"
    end
    return {user_id: self.id, via: 'stripe', amount: amount,
           payment_processed: payment_processed, error_message: error_message}
  end

  def create_account_child
    build_account
    true
  end

end
