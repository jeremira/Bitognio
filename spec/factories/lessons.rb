FactoryBot.define do
  factory :lesson do
    student
    teacher
    date "2099-01-17"
    time "14:30:00"
  end
end
