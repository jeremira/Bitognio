class CareersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    unless current_user.is_a_teacher
      @career = current_user.build_career
    end
  end

  def create
    token = params[:token]
    iban = "DE89370400440532013000" #test token from stripe
    #iban = "FR1420041010050500013M02606"

    bank_token = Stripe::Token.create(
      :bank_account => {
        :country => "FR",
        :currency => "eur",
        :account_number => "FR89370400440532013000"
      }
    )
    p bank_token
    acct = Stripe::Account.create({
      country: "FR",
      type: "custom",
      email: current_user.email,
      account_token: token,
    })
    acct.external_accounts.create(:external_account => bank_token)
    p acct
  end

end
