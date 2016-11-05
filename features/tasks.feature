Feature: Testing tasks
  In order to validate correct functionality
  On list detail page

  Background:
    Given there are the following lists:
      | id | name       | description       |
      | 1  | List 1     | some description  |
      | 2  | List 2     | another description  |

    Given there are the following tasks
      | id  | name           | priority   | list_id |
      | 1   | Task 1         | -1         | 1       |
      | 2   | Task 2         | 23         | 1       |
      | 3   | Task 3         | -3         | 1       |
      | 4   | Task 4         | 0          | 2       |

  Scenario: Viewing correct entries
    When I am on list "1" detail page
    Then I should see "some description"
    And I should see "Task 3" inside the "#tasks_table" table in row "1"
    And I should see "Task 1" inside the "#tasks_table" table in row "2"
    And I should see "Task 2" inside the "#tasks_table" table in row "3"
    And I should not see "Task 4"

  Scenario: Trying to visit task edit page
    When checking pages that should not exist
    Then I should not be able to get on list "1" task "1" edit page

  Scenario: Trying to visit task detail page
    When checking pages that should not exist
    And I should not be able to get on list "1" task "1" detail page

  Scenario: Trying to visit task update page
    When checking pages that should not exist
    And I should not be able to get on list "1" task "1" update page

  Scenario: Validating default priority for new task
    When I am on list "1" detail page
    And I click "New Task"
    Then I should see "0" inside "Priority" input

  Scenario: Creating valid task
    When I am on list "1" detail page
    And I click "New Task"
    And I fill "Most important task" inside "Name"
    And I fill "-1000" inside "Priority"
    Then I press "Save"
    And I should be on list "1" detail page
    And I should see "Most important task" inside the "#tasks_table" table in row "1"
    And there should be "4" tasks for list "1" in the database

  Scenario: Creating invalid task (blank name)
    When I am on list "1" detail page
    And I click "New Task"
    And I press "Save"
    Then I should be on new list "1" task page
    And I should see "Name can't be blank"
    And there should be "3" tasks for list "1" in the database

  Scenario: Creating invalid task (blank priority)
    When I am on list "1" detail page
    And I click "New Task"
    And I fill "" inside "Priority"
    And I press "Save"
    Then I should be on new list "1" task page
    And I should see "Priority can't be blank" or "Priority is not a number"
    And there should be "3" tasks for list "1" in the database

  Scenario: Creating invalid task (invalid priority format)
    When I am on list "1" detail page
    And I click "New Task"
    And I fill "wrong format" inside "Priority"
    And I press "Save"
    Then I should be on new list "1" task page
    And I should see "Priority is not a number"
    And there should be "3" tasks for list "1" in the database

  Scenario: Completing a task
    When I am on list "1" detail page
    And I complete "Task 1"
    Then I should be on list "1" detail page
    And I should not see "Task 1" inside the "#tasks_table"
    Then I click "View completed tasks"
    And I should see "Task 1" inside the "#tasks_table" table in row "1"

  Scenario: Removing a task
    When I am on list "1" detail page
    And I remove "Task 1"
    Then I should be on list "1" detail page
    And I should not see "Task 1" inside the "#tasks_table"
    Then I click "View completed tasks"
    And I should not see "Task 1" inside the "#tasks_table"

  Scenario: Viewing completed tasks (in correct order)
    When I am on list "1" detail page
    And I complete "Task 1"
    And I complete "Task 3"
    And I click "View completed tasks"
    Then I should see "Task 3" inside the "#tasks_table" table in row "1"
    And I should see "Task 1" inside the "#tasks_table" table in row "2"
    And I should not see "Task 2" inside the "#tasks_table"
