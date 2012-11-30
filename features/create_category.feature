Feature: Create categories
  As a blog administrator
  In order to organize my content more efficiently
  I want to be able to create and edit categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Successfully show categories page
    When I follow "Categories"
    Then I should see "Categories"
    And I should see "Name"
    And I should see "Keywords"
    And I should see "Permalink"
  
  Scenario: Create a category
    Given I am on the admin categories page
    When I fill in "category_name" with "New category 1"
    And I fill in "category_keywords" with "new, category"
    And I fill in "category_description" with "This is a new category."
    And I press "Save"
    Then I should be on the admin categories page
    And The "category_container" table should have 2 rows
  
  Scenario: Edit a category
    Given I am on the admin categories page
    When I follow "General"
    Then I should see "General" in the "Name" field
    Then I fill in "category_name" with "General_modif"
    And I press "Save"
    Then I should be on the admin categories page
    And I should see "General_modif"
    
