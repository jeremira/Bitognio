Feature: Add money to your account balance using stripe/Credit card

Scenario: A student can make payments
  Given I am a registered student
  And Tomoko is logged in
  And I am on the home page
  When I click on link 'Payments'
  Then I should see 'Your account balance is : 0 Yen'
  When I click on link 'Pay 3000 Yen'
  Then I should see 'Payment confirmation : 3000 Yen'
  When I pay 3000 by credit card
  Then I should see 'Payment successful !'
  And  I should see 'Your account balance is : 3000 Yen'
  When I click on link 'Pay 15000 Yen'
  Then I should see 'Payment confirmation : 15000 Yen'
  When I pay 15000 by credit card
  Then I should see 'Payment successful !'
  And  I should see 'Your account balance is : 18000 Yen'
