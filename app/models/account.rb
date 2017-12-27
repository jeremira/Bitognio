class Account < ApplicationRecord
  belongs_to :user

  validates :balance, presence: true

  def update_balance amount
    self.balance += amount
    self.save
  end

end
