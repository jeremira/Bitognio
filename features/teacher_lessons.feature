Feature: A student can look for teacher and request a lesson

Background:
  Given Student Tomoko exist
  And   Teacher Robert exist
  And   Robert is log in

Scenario: Teacher cant request new lesson
  Given I click on link 'Lessons'
  Then I should not see 'Plan your lessons :'

Scenario: Robert approve a request lesson
  Given Tomoko requested a new lesson
  And I click on link 'Lessons'
  Then I should see 'New request from tomoko@cucumber.com'
  When I click on link 'Confirm this lesson'
  Then I should see 'Lesson confirmed !'
  And I should see 'Lesson with tomoko@cucumber.com'
  And I should see 'This lesson is not pay yet'
  When Tomoko pay the lesson
  And I click on link 'Lessons'
  Then I should see 'Lesson with tomoko@cucumber.com'
  And I should see 'This lesson has been payed'

Scenario: Robert cancel the request
  Given Tomoko requested a new lesson
  And I click on link 'Lessons'
  Then I should see 'New request from tomoko@cucumber.com'
  When I click on link 'Cancel'
  Then I should see 'Lesson canceled !'
  And I should not see 'New request from tomoko@cucumber.com'
