class Payment < ApplicationRecord
  belongs_to :user

  validates :via,    presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}

end
