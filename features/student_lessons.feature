Feature: A student can look for teacher and request a lesson

Background:
  Given Teacher Robert exist
  And   Student Tomoko exist
  And Tomoko is log in

Scenario: Tomoko can look for teacher and request lesson
  Given I click on link 'Lessons'
  Then I should see 'Plan your lessons :'

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

Scenario: Tomoko pay her lesson
  Given I request a new lesson
  And I have some funds
  And Robert confirm the lesson
  When I click on link 'Pay my lesson'
  Then I should see 'This lesson has been pay to robert@cucumber.com. Thank you !'
  And  I should not see 'Pay my lesson'

Scenario: Tomoko wanna pay her lesson but she got no money because it's rough time man recession and stuff
  Given I request a new lesson
  And Robert confirm the lesson
  When I click on link 'Pay my lesson'
  Then I should see 'Not enough money : 0'
  And I should see 'My account balance is : 0 Yen'
  When I click on link 'Lessons'
  Then I should see 'Pay my lesson'
