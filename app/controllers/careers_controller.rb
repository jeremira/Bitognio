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
    @career = current_user.build_career(career_params)

    if @career.save
      begin
        #create bank account token
        bank_token = Stripe::Token.create(
          :bank_account => {
            :country => @career.country,
            :currency => "eur",
            :account_number => @career.iban
          }
        )
        #create stripe account token
        account_token = Stripe::Token.create(
          :account => {
            legal_entity: {
              type: 'individual',
              first_name: @career.first_name,
              last_name: @career.last_name,
              address: {
                line1: @career.adress,
                city: @career.city,
                postal_code: @career.zipcode,
              },
              dob: {
                day: @career.dob.day,
                month: @career.dob.month,
                year: @career.dob.year,
              }
            },
            tos_shown_and_accepted: true
          }
        )
        #create stripe account
        account = Stripe::Account.create({
          country: "FR",
          type: "custom",
          email: current_user.email,
          account_token: account_token,
        })
        #link bank account to stripe connect account
        account.external_accounts.create(external_account: bank_token)
      rescue
        @career.destroy!
        redirect_to current_user, notice: 'Stripe creation error'
      else
        #save only first 6 digit of iban for privacy
        @career.iban = @career.iban[0..6]
        @career.save
        current_user.is_a_teacher = true
        current_user.save
        redirect_to current_user, notice: 'You are now a teacher !'
      end

    else
      flash.now[:alert] = "Invalid imput to create a career"
      render :new
    end


  end

  private

    def career_params
      params.require(:career).permit(:user_id, :last_name, :first_name, :dob, :country, :adress, :city, :zipcode, :iban)
    end

end
