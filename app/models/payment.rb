class Payment < ApplicationRecord
  belongs_to :user

  validates :via,    presence: true
  validates :amount, numericality: {greater_than: 0}

  def process_stripe_charge(amount, email, token)
    begin
      customer = Stripe::Customer.create(
        :email => email,
        :source  => token
      )
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => amount,
        :description => 'French lesson',
        :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      amount_payed = 0
      error =  e.message
    rescue
      raise 'Error Stripe'
    else
      error = 'NONE'
      amount_payed = amount
    end
    self.attributes = { via: 'stripe',
                        amount: amount_payed,
                        error: error }
    if self.save
      self
    else
      false
    end
    
   end

end
