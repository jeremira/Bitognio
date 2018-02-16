class Career < ApplicationRecord

  #Handle stripe connect creation method
  include ConnectStripe

  belongs_to :user

  before_create :upgrading_to_teacher_account
  after_create  :user_become_a_teacher

  validates_presence_of [:last_name, :first_name, :dob, :country, :adress, :city, :zipcode, :iban]

  private

    def upgrading_to_teacher_account
      begin
        account = self.create_stripe_connect_account
      rescue => e
        #puts "Error creation : #{e}"
        #career record is not created
        throw :abort
      else
        #save only first 6 digit of iban for privacy
        self.iban = self.iban[0..6]
        self.connect_account_id = account[:id]
        return true
      end
    end

    def user_become_a_teacher
      if self.connect_account_id
        self.user.is_a_teacher = true
        self.user.save
      end
    end

end
