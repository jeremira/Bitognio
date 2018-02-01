Feature: The website can be accessed in english or in japanese.

Scenario: The website is displayed in English by default
  Given I am on the home page
  Then The website should be displayed in english

Scenario: User can switch beetween English and Japanese version
  Given I am on the home page
  And I click the japanese flag
  Then The website should be displayed in japanese
  When I click the english flag
  Then The website should be displayed in english
