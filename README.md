# Rails - simple ToDo App

Please read carefully. Tests are written in human-accptable form, so if you have any question about the behaviour, look
what the tests are expecting.

## Setup

**you will need ruby with version above 2.2.2**

Run:
````bundle install````
to install all required gems

Run:
```rails server``` to start the web server

You should see the Rails intro screen located on default port 3000

**http://localhost:3000**

![Rails intro screen](http://guides.rubyonrails.org/images/getting_started/rails_welcome.png)

Run:
```cucumber``` to execute the tests.

You dont need to check rubocop in this assignment.

### !!! Important !!!
Use generators, however be careful what you overwrite!. There are already some files created which the scaffold generator
for example will try to create.

Rails will ask you if you want to overwrite those files. Always select **NO**.

DO NOT CHANGE VIEWS OR TESTS.

## Your goal:
* implement a simple todo that can track tasks to be done and group them in lists
* lists and tasks have 1:N relationship (each task belongs exactly to one list and each list can have more tasks)

## Model

Required attributes and models:

**List**
* **name** - type string, validations: required, uniq
* **description** - type text, validations: required

**Task**
* **list_id** - type reference, validations: required
* **name** - type string, validations: required
* **priority** - type, default: 0, validations: required, numerical

Feel free to add any other necessary models/attributes

## Behaviour


### Lists
* All basic CRUD operations are available on list
  * List can be created, edited, deleted
* Deletion is a special case, when deleting a list, we should delete all his belonging tasks from the database as well
* Pages:
  * Index page

    Index page expects two variables to be set:

    **@lists** - collection of all lists ordered by name (ascending)

    **@important** - collection of all important tasks (task is important when
    its priority is below 0)
  * New / edit page
  * Detail page

    Shows selected list and renders all available tasks.

    Tasks are ordered by priority (ascending)

    The view calls @list.tasks to get the collection of tasks, so completed hiding should be defined in default scope,
    as well as the ordering.

  * Completed page

    As well as detail page completed page is defined on member (requires list_id) and shows all tasks that
    are already completed

    Your controller action should set the instance variable **@completed_tasks** with collection of completed tasks and
    reuse the view from action *show*

    Completed tasks should be ordered the same way as tasks on detail page


Notes:
* creating/updating a list will redirect you to list detail page
* deleting a list will redirect you to lists index page


### Tasks

Task belongs to list.
They can not be created on their own or have their own display page.

Tasks are only displayed on list detail page.

Task can be created, completed and deleted.
You **can not** edit a task.

After setting task to complete, it can be only deleted. Reverting is not allowed.

Default ordering is by priority (ASC) and completed tasks are hidden.
(e.g. Task.all should not return completed tasks)

Tasks controller should also have action for setting task as completed a task named **complete**.

## Sources and links

Guides: http://guides.rubyonrails.org/

Demo: https://fi-muni-todoapp-2016.herokuapp.com/
* may be bugged (just a quick way to show how the app should behave)

### Fight with it! This task does not require plenty of coding.