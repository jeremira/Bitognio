Feature: A student can post a postit to find an available teacher

Background:
  Given Student Tomoko exist
  And   Teacher Robert exist
  And   Tomoko is log in

Scenario: Student can make a new postit and delete it
  Given I click on link 'Lessons'
  And I click on link 'Find a teacher'
  Then I should see 'All our teachers :'
  And I should see 'Robert'
  When I fill-in postit form and submit it
  Then I should see 'Your new postit has been post !'
  And I should see 'I am looking for a teacher !'
  And I should see 'No teacher found yet, check back in a while !'
  When I click on link 'I don't look anymore'
  Then I should see 'Your postit is deleted'
  And I should not see 'I am looking for a teacher !'

Scenario: Student can book a lesson with availables teacher
  Given Tomoko has an open postit
  And Robert declared himself as available
  Then I should see 'Robert is available !'
  When I click on link 'Book a lesson'
  Then I should see 'Ask for a new lesson'
  When I fill-in the date and time
  And I click on button 'Request lesson'
  Then I should see 'Thanks, your request has been sent to Robert'
