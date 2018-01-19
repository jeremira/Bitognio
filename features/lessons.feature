Feature: A student can look for teacher and request a lesson

Background:
  Given Teacher Robert exist
  And Tomoko register and log in

Scenario: Tomoko request a new lesson with Robert
  Given I request a new lesson
  Then I should see 'Thanks, your request has been sent to Robert'

Scenario: Tomoko request a lesson but dont fill in all necessary Informations
  Given I request a lesson without providing a date and time
  Then I should see 'Sorry, we could not book this lesson.'

Scenario: Tomoko cancel a request
  Given I request a new lesson
  And I click on link 'Cancel'
  Then I should see 'Lesson canceled !'
