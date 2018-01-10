Feature: A student can log in and log out

Scenario: A student log in then log out with valid credential
  Given I am a registered student
  And I am on the home page
  When I click on link 'Log in'
  And I fill in and submit log in form with 'tomoko@cucumber.com' and 'password1234'
  Then I should see 'Signed in successfully.'
  And I should be logged in
  When I click on link 'Log out'
  Then I should see 'Signed out successfully.'
  And I should be logged out
