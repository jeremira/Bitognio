FactoryBot.define do
  factory :payment do
    from "Stripe"
    to 785
    amount 1000
    user
  end
end
