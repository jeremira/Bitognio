#Add payment method to User like model
module ConnectStripe

  def connect_stripe_balance
      acct_id = self.connect_account_id
      acct = Stripe::Account.retrieve(acct_id)
      balance = Stripe::Balance.retrieve(
        {stripe_account: acct[:id]}
        )
        return balance
  end

  def transfer_funds amount
    if self.connect_account_id == "acct_testaccount123456"
      #by pass Stripe API call for test
      return true
    else
      #puts "Starting transfer..."
      Stripe::Transfer.create(
        :amount => amount,
        :currency => "eur",
        :destination => self.connect_account_id
      )
    end
  end

  def create_stripe_connect_account
    career = self
    if career.iban == "FR89370400440532013000" && career.zipcode == "75014"
      #by pass all Stripe API call when IBAN is a test value
      return {id: 'acct_testaccount123456'}
    else
      #call stripe API and create connected account with linked bank account
      puts "Creating stripe account..."
      #create bank account token
      bank_token = Stripe::Token.create(
        :bank_account => {
          :country => 'FR',
          :currency => "eur",
          :account_number => career.iban
        }
      )
      #puts "Bank token : #{bank_token}"
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
      #puts "Account Token : #{account_token}"
      #create stripe account
      account = Stripe::Account.create({
        country: "FR",
        type: "custom",
        email: career.user.email,
        account_token: account_token,
      })
      #puts "Account : #{account}"
      #link bank account to stripe connect account
      account.external_accounts.create(external_account: bank_token)
      puts "Stripe account created ! #{account.id}"
      return account
    end
  end

end
