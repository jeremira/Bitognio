#Add payment method to User like model
module ConnectStripe

  def create_stripe_connect_account
    career = self
    #create bank account token
    bank_token = Stripe::Token.create(
      :bank_account => {
        :country => 'FR',
        :currency => "eur",
        :account_number => career.iban
      }
    )
    #create stripe account token
    account_token = Stripe::Token.create(
      :account => {
        legal_entity: {
          type: 'individual',
          first_name: career.first_name,
          last_name: career.last_name,
          address: {
            line1: career.adress,
            city: career.city,
            postal_code: career.zipcode,
          },
          dob: {
            day: career.dob.day,
            month: career.dob.month,
            year: career.dob.year,
          }
        },
        tos_shown_and_accepted: true
      }
    )
    #create stripe account
    account = Stripe::Account.create({
      country: "FR",
      type: "custom",
      email: career.user.email,
      account_token: account_token,
    })
    #link bank account to stripe connect account
    account.external_accounts.create(external_account: bank_token)
    return account
  end

end
