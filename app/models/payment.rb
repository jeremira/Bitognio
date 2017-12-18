class Payment < ApplicationRecord
  belongs_to :user

  validates :via,    presence: true
  validates :amount, numericality: {greater_than: 0}

  #Process stripe payment and return a new Payment instance pre-populated
  def self.process_stripe_charge(options={})
    user_id = options[:user_id]
    amount  = options[:amount]
    token   = options[:token]
    payment_processed = false
    error_message = nil
    begin
      # Charge the user's card:
      charge = Stripe::Charge.create(
        :amount => amount,
        :currency => "usd",
        :description => "Lesson charge",
        :source => token,
      )
    rescue Stripe::CardError => e
      amount = 0
      error_message =  e.message
    rescue
      amount = 0
      error_message =  "Invalid Argument : #{options.inspect}"
    else
      payment_processed = true
    end

    Payment.new(via: 'stripe',
                amount: amount,
                user_id: user_id,
                payment_processed: payment_processed,
                error_message: error_message)

   end

end
