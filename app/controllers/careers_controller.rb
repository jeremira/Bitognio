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
    #FR89370400440532013000 fake stripe iban
    if @career.save

      begin
  puts 'Starting stripe creation...'

        #create bank account token
        bank_token = Stripe::Token.create(
          :bank_account => {
            :country => 'FR',
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
      rescue => e
        puts e
        @career.destroy!
        redirect_to current_user, notice: 'We could not create your teacher account, please try again'
      else
        #save only first 6 digit of iban for privacy
        @career.iban = @career.iban[0..6]
        @career.save
        current_user.is_a_teacher = true
        current_user.save
        redirect_to current_user, notice: 'You are now a teacher !'
      end
    else
      flash.now[:alert] = "Something went wrong..."
      render :new
    end


  end

  private

    def career_params
      params.require(:career).permit(:user_id, :last_name, :first_name, :dob, :country, :adress, :city, :zipcode, :iban)
    end

end
