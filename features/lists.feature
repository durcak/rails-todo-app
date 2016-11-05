Feature: Testing task lists
  In order to validate correct functionality
  On home page

  Background:
    Given there are the following lists:
      | id | name       | description       |
      | 1  | List 1     | some description  |
      | 2  | B List     | more description  |
      | 3  | List 2     | more description  |
      | 4  | A List     | more description  |

    Given there are the following tasks
      | id  | name           | priority   | list_id |
      | 1   | Task 1         | -1         | 1       |
      | 2   | Task 2         | 23         | 1       |
      | 3   | Task 3         | -3         | 4       |

  Scenario: Listing most important tasks (sorted by priority from lowest)
    When I am on the root page
    Then I should see "Task 3" inside the "#most_important" table in row "1"
    And I should see "Task 1" inside the "#most_important" table in row "2"
    And I should not see "Task 2" inside the "#most_important"

  Scenario: Listing all lists (sorted by name asc)
    When I am on the root page
    Then I should see "A List" inside the "#lists_table" table in row "1"
    And I should see "more description" inside the "#lists_table" table in row "1"
    And I should see "List 1" inside the "#lists_table" table in row "3"
    And I should see "some description" inside the "#lists_table" table in row "3"

  Scenario: Creating a list (validates name presence)
    When I am on new list page
    And I fill "My new cool tasks list" inside "Description"
    And I press "Save"
    Then I should see "Name can't be blank"
    And there should be "4" lists in the database

  Scenario: Creating a list (validates name uniqueness)
    When I am on new list page
    And I fill "List 1" inside "Name"
    And I fill "My new cool tasks list" inside "Description"
    And I press "Save"
    Then I should see "Name has already been taken"
    And there should be "4" lists in the database

  Scenario: Creating a list (validates description presence)
    When I am on new list page
    And I fill "My new cool tasks list" inside "Name"
    And I press "Save"
    Then I should see "Description can't be blank"
    And there should be "4" lists in the database

  Scenario: Creating a list (should be redirected to list show page)
    When I am on new list page
    And I fill "Newly created list" inside "Name"
    And I fill "My new cool tasks list" inside "Description"
    And I press "Save"
    Then I should be on list "Newly created list" detail page
    And there should be "5" lists in the database

  Scenario: Editing a list
    When I am on list "1" edit page
    And I fill "Edited list" inside "Name"
    And I press "Save"
    Then I should be on list "Edited list" detail page
    And there should be "4" lists in the database

  Scenario: Deleting a list (with all the tasks)
    When I am on list "1" detail page
    And I complete "Task 1"
    And I am on the root page
    And I delete "List 1"
    Then I should be on root page
    And I should not see "Task 1"
    And I should not see "Task 2"
    And I should not see "List 1"
    And there should be "3" lists in the database
    And there should be "1" tasks in the database

  Scenario: I should not see completed items as most important
    When I am on list "1" detail page
    And I complete "Task 1"
    And I am on the root page
    Then I should not see "Task 1" inside the "#most_important"

  Scenario: Completing important task
    When I am on the root page
    And I complete important "Task 1"
    Then I should be on list "1" detail page
    And I should not see "Task 1" inside the "#tasks_table"
