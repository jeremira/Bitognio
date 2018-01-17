FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    password_confirmation "password"
  end
end

FactoryBot.define do
  factory :student, class: 'User' do
    sequence(:email) { |n| "student#{n}@test.com" }
    password "password"
    password_confirmation "password"
    is_a_teacher false
  end
end

FactoryBot.define do
  factory :teacher, class: 'User' do
    sequence(:email) { |n| "teacher#{n}@test.com" }
    password "password"
    password_confirmation "password"
    is_a_teacher true
  end
end
