Feature: Article merging
  As a blog administrator
  In order to group together different articles on the same topic
  I want to merge two articles into one
  
  Background:
    Given the blog is set up
    And I am logged into the admin panel
  
  Scenario: Merge article option is shown
    Given I am on the edit page of article "1"
    Then I should see "Merge Articles"
    And I should see "Article ID"

  Scenario: Non-admin cannot merge articles
    Given I am logged into the admin panel as a non-admin
    And I am on the edit article page
    Then I should not see "Merge Articles"
    And I should not see "Article ID"
  
  Scenario: Successfully merge articles
    Given I am on the edit page of article "1"
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then I should see "Hello World" 3 times
  
  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am on the edit page of article "1"
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then the merged article should have "Welcome to Typo" 2 times

