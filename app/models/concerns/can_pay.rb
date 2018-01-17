#Add payment method to User like model
module CanPay

  def transfer_money_to_teacher teacher, amount
    student_balance = self.account.balance
    payment_processed = false
    error_message = nil

    if student_balance >= amount
      remove_money_from_account_balance self, amount
      add_money_to_account_balance teacher, amount
      payment_processed = true
    else
      error_message = "Not enough money : #{student_balance}"
    end

    return {user_id: self.id, from: 'self', to: teacher.id, amount: amount,
           payment_processed: payment_processed, error_message: error_message}

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
        add_money_to_account_balance self, amount
      end
    else
      error_message = "Amount too low"
    end

    return {user_id: self.id, from: 'stripe', to: self.id, amount: amount,
           payment_processed: payment_processed, error_message: error_message}
  end

  private
    def add_money_to_account_balance user, amount
      user.account.balance += amount
      user.account.save
    end

    def remove_money_from_account_balance user, amount
      user.account.balance -= amount
      user.account.save
    end
end