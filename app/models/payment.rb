class Payment < ApplicationRecord
  belongs_to :user

  validates :via,    presence: true
  validates :amount, numericality: {greater_than: 0}
  
end
