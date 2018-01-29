Feature: A student can look for teacher and request a lesson

Background:
  Given Student Tomoko exist
  And Robert register and log in

Scenario: Robert approve a request lesson
  Given Tomoko requested a new lesson
  And I click on link 'Lessons'
  Then I should see 'Lessons teachers'
  Then I should see 'New request from tomoko@cucumber.fr'
  When I click on link 'Approve the request'
  Then I should see 'Lesson confirmed !'
  And I should not see 'New request from tomoko@cucumber.fr'
  And I should see 'Lesson confirmed with tomoko@cucumber.fr : not payed'
  When Tomoko pay the lesson
  And I click on link 'Lessons'
  Then I should see 'Lesson confirmed with tomoko@cucumber.fr : payed'

Scenario: Robert cancel the request
  Given Tomoko requested a new lesson
  And I click on link 'Lessons'
  Then I should see 'New request from tomoko@cucumber.fr'
  When I click on link 'Cancel the request'
  Then I should see 'Lesson was cancel !'
  And I should not see 'New request from tomoko@cucumber.fr'
