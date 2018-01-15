Feature: Visiter can send a message through the contact form

Scenario: A visiter try to send a message
  Given I am on the home page
  Then I should see 'To contact us'
  When I fill in the contact form
  Then An email should be send to the admin
