class Payment < ApplicationRecord
  
  belongs_to :user

  validates :from,    presence: true
  validates :to,      presence: true
  validates :amount,  numericality: {greater_than_or_equal_to: 0}

end
