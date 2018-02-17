Feature: A student can upgrade his account and become a teacher

Background:
  Given Student Tomoko exist
  Given Teacher Robert exist

Scenario: Tomoko upgrade her account and become a teacher
  Given Tomoko is log in
  And I click on link 'My account'
  And I click on link 'Become a teacher'
  Then I should see 'To become a teacher :'
  When I click on link 'Ok, got it !'
  And I fill in and submit teacher information form
  Then I should see 'You are now a teacher !'
  When I click on link 'My account'
  Then I should see 'is a teacher'

Scenario: Robert can see his balance
  Given Robert is log in
  When I click on link 'Payments'
  Then I should see 'Your balance is send to your bank account starting with IBAN FR89370 on a weekly basis.'
  When I am logged out
  And Tomoko is log in
  And I have some funds
  And Tomoko pay a lesson to Robert
  And I am logged out
  And Robert is log in
  When I click on link 'Payments'
  Then I should see 'Payment from tomoko@cucumber.com'
