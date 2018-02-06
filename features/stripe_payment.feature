Feature: Add money to your account balance using stripe/Credit card

Scenario: A student can make payments
  Given Student Tomoko exist
  And Tomoko is log in
  And I am on the home page
  When I click on link 'Payments'
  Then I should see 'My account balance is : 0 Yen'
  When I click on link 'Pay 3000 Yen'
  Then I should see 'Payment confirmation : 3000 Yen'
  When I pay 3000 by credit card
  Then I should see 'Payment successful !'
  And  I should see 'My account balance is : 3000 Yen'
  When I click on link 'Pay 15000 Yen'
  Then I should see 'Payment confirmation : 15000 Yen'
  When I pay 15000 by credit card
  Then I should see 'Payment successful !'
  And  I should see 'My account balance is : 18000 Yen'

Scenario: A teacher cant make payments
  Given Teacher Robert exist
  And Robert is log in
  When I click on link 'Payments'
  Then I should see 'My account balance is : 0 Yen'
  And I should not see 'Pay 3000 Yen'
