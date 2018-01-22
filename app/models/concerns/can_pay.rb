#Add payment method to User like model
module CanPay

  def transfer_money_to_teacher teacher, amount
    student_balance = account_balance self
    payment_processed = false
    error_message = nil

    if student_balance >= amount
      remove_money_from_account_balance self, amount
      add_money_to_account_balance teacher, amount
      payment_processed = true
    else
      error_message = "Not enough money : #{student_balance}"
    end

    payment_attributes = {from: 'self', to: teacher.id, amount: amount,
                          payment_processed: payment_processed,
                          error_message: error_message}
    payment = self.payments.build(payment_attributes)

    if payment.save
      return payment
    else
      raise "CanPay Error : could not save Transfer payment record"
    end

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
        error_message =  "Could not pay : Token absent or corrupted"
      else
        payment_processed = true
        add_money_to_account_balance self, amount
      end
    else
      error_message = "Could not pay : Amount too low"
    end

    payment_attributes = {user_id: self.id, from: 'stripe', to: self.id, amount: amount,
                          payment_processed: payment_processed,
                          error_message: error_message}
    payment = self.payments.build(payment_attributes)
    if payment.save
     return payment
    else
     raise "CanPay Error : could not save Stripe payment record"
    end

  end

  private
    def account_balance user
      user.account.balance
    end

    def add_money_to_account_balance user, amount
      user.account.balance += amount
      user.account.save
    end

    def remove_money_from_account_balance user, amount
      user.account.balance -= amount
      user.account.save
    end
end
