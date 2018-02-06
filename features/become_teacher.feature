Feature: A student can upgrade his account and become a teacher

Background:
  Given Student Tomoko exist
  And Tomoko is log in

Scenario: Tomoko upgrade her account and become a teacher
  Given I click on link 'My account'
  And I click on link 'Become a teacher'
  Then I should see 'To become a teacher :'
  When I fill in and submit teacher information form
  Then I should see 'Thanks, you are now a teacher !'
  When I click on link 'My account'
  Then I should see 'is a teacher'
