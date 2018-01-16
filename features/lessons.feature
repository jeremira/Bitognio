@wip
Feature: A student can look for teacher and book lessons

Scenario: Tomoko request a new lesson with Robert
  Given Tomoko is logged in
  And I click on link 'Lessons'
  When I click on link 'New lesson request'
  And I fill in the request lesson form
  Then I should see 'Thanks, your request has been sent to Robert'


Scenario: Tomoko cancel a request
  Given Tomoko is logged in
  And I click on link 'Lessons'
  And I click on link 'New lesson request'
  And I fill in the request lesson form
  And I click on link 'Cancel this lesson'
  Then I should see 'This lesson has been cancel !'
