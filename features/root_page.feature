Feature: Home page can be accessed

Scenario: A visiter navigate the home page
  Given I am on the home page
  Then I should be logged out
  And I should see 'French lessons'

Scenario: A student navigate the home page
  Given I am a registered student
  And Tomoko is logged in
  When I am on the home page
  And I click on link 'My account'
  Then I should see 'Welcome, tomoko@cucumber.com !'
  When I click on link 'Log out'
  Then I should see 'Signed out successfully.'
