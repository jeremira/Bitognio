FactoryBot.define do
  factory :career do
    user
    last_name "Baratheon"
    first_name "Robert"
    dob "1990-02-02 13:00:00"
    country "FR"
    adress "1, red keep"
    city "King's landing"
    zipcode "75014"
    iban "FR89370400440532013000" #fake Stripe Connect Iban number
    connect_account_id nil
  end
end
