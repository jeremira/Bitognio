Feature: Home page is available

Scenario: A visiter land on the home page
  Given I am on the home page
  Then I should be logged out
  And I should see 'French lessons'

Scenario: A student navigate the home page
  Given Student Tomoko exist
  And Tomoko is log in
  When I am on the home page
  And I click on link 'My account'
  Then I should see 'Welcome, tomoko@cucumber.com !'
  And I should see 'is a student'
  When I click on link 'Log out'
  Then I should see 'Signed out successfully.'

  Scenario: A teacher navigate the home page
    Given Teacher Robert exist
    And Robert is log in
    When I am on the home page
    And I click on link 'My account'
    Then I should see 'Welcome, robert@cucumber.com !'
    And I should see 'is a teacher'
    When I click on link 'Log out'
    Then I should see 'Signed out successfully.'
