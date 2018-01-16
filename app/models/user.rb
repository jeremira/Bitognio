class User < ApplicationRecord
  has_many :payments
  has_one  :account

  before_create :create_account_child

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Handle payment method
  include CanPay

  def create_account_child
    build_account
    true
  end

end
