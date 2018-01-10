Feature: A student can make a payment using his credit card

@javascript
Scenario: A student can make an initial payment
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

Scenario: A student can add more money to his account balance

Scenario: A student can not pay with an invalid card
