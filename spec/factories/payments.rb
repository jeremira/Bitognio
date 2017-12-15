FactoryBot.define do
  factory :payment do
    via "Stripe"
    amount 1000
    user
  end
end
