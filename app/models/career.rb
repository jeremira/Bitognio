class Career < ApplicationRecord
  belongs_to :user

  #before_create :create_connect_account

  validates_presence_of [:last_name, :first_name, :dob, :country, :adress, :city, :zipcode]

  def create_connect_account
    token = params[:token]
    acct = Stripe::Account.create({
      :country => "US",
      :type => "custom",
      :account_token => token,
    })
    p acct
  end


  private

    def boubacreate_connect_account
      puts "Conect account creation....."
      begin
        puts "Initiz..."
        acct = Stripe::Account.create({
          :country => "FR",
          :type => "custom",
          email: self.user.email,
          external_account: "test_token",
          legal_entity: {
            first_name: self.first_name,
            last_name: self.last_name,
            address: {
              city: self.city,
              line1: self.address,
              postal_code: self.zipcode
            },
            dob: {
              day: self.dob.day,
              month: self.dob.month,
              year: self.dob.year
            }
          },
          tos_acceptance: {
            date: self.dob.to_time.utc.to_i,
            ip: request.remote_ip
          }
        })
      rescue
        p acct
        return false
      else
        p acct
        link_connect_account acct
      end

    end

    def link_connect_account account_id
      self.connect_account_id = account_id
    end
end
