Feature: Home page can be accessed

Scenario: A visiter navigate the home page
  Given I am on the home page
  Then I should be logged out
  And I should see 'Signup and enjoy a free trial'
  When I click on link 'Informations'
  Then I should see 'Bitognio'
  When I click on link 'Contact'
  Then I should see 'To contact us'
  When I click on link 'Log in'
  Then I should see 'Log in to Bitognio'
  When I click on link 'Signup'
  Then I should see 'Signup to Bitognio'

Scenario: A student navigate the home page
  Given I am a registered student
  And I am logged in
  When I am on the home page
  Then I should see 'Plan your lessons now !'
  When I click on link 'Lessons'
  Then I should see 'Plan a new lesson now !'
  When I click on link 'Payments'
  Then I should see 'Make a new payment'
  When I click on link 'My account'
  Then I should see 'Welcome, studend@cucumber.com !'
  When I click on link 'Log out'
  Then I should see 'Signed out successfully.'
