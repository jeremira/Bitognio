FactoryBot.define do
  factory :admin, class: AdminUser do
    sequence(:email) { |n| "admin#{n}@test.com" }
    password "password"
    password_confirmation "password"
  end
end
