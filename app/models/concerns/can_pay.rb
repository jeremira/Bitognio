#Add payment method to User like model
module CanPay

  def add_money_to_account_balance amount
    self.account.balance += amount
    self.account.save
  end

  def remove_money_from_account_balance amount
    self.account.balance -= amount
    self.account.save
  end

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

    return {user_id: self.id, from: 'stripe', to: self.id, amount: amount,
           payment_processed: payment_processed, error_message: error_message}
  end
end
