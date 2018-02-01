Feature: A new user can create his account and log-in on the site

Scenario: A student succesfully create a new account
  Given I am on the home page
  When I click on link 'Sign up'
  And I fill in and submit signup form with 'valid@cucumber.com' and 'password1234'
  Then I should see 'Welcome! You have signed up successfully.'
  And I should be logged in
