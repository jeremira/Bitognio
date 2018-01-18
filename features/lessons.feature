Feature: A student can look for teacher and request a lesson

Background:
  Given Teacher Robert exist
  And Tomoko register and log in

Scenario: Tomoko request a new lesson with Robert
  Given I request a new lesson
  Then I should see 'Thanks, your request has been sent to Robert'

Scenario: Tomoko cancel a request
  Given I request a new lesson
  And I click on link 'Cancel this lesson'
  Then I should see 'Lesson canceled !'
