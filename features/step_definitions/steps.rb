Given(/^there are the following lists:$/) do |table|
  table.hashes.each do |hash|
    List.create!(hash)
  end
end

Given(/^there are the following tasks$/) do |table|
  table.hashes.each do |hash|
    Task.create!(hash)
  end
end

When(/^I am on the root page$/) do
  visit '/'
end

When(/^I am on new list page$/) do
  visit '/lists/new'
end

Then(/^I should see "([^"]*)" inside the "([^"]*)" table in row "([^"]*)"$/) do |expected, table_selector, row_num|
  table = page.find(table_selector)
  row = table.all('tr')[row_num.to_i]

  expect(row).to have_content(expected)
end

Then(/^I should not see "([^"]*)" inside the "([^"]*)"$/) do |expected, table_selector|
  table = page.find(table_selector)

  expect(table).not_to have_content(expected)
end


When(/^I fill "([^"]*)" inside "([^"]*)"$/) do |value, input|
  fill_in(input, with: value)
end

When(/^I press "([^"]*)"$/) do |btn|
  click_button(btn)
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Then(/^I should be on list "([^"]*)" detail page$/) do |list_name|
  h2 = page.first('h2')
  expect(h2).to have_content(list_name)
  expect(page.current_path =~ /\/lists\/\d+/).to be(0)
end

When(/^I am on list "([^"]*)" edit page$/) do |id|
  visit "/lists/#{id}/edit"
end

When(/^I pry$/) do
  binding.pry
end

When(/^I delete "([^"]*)"$/) do |name|
  lists_table = page.find("#lists_table")
  tr = lists_table.find('tr', text: name)
  tr.click_link('Remove')
end

Then(/^I should be on root page$/) do
  expect(page.current_path).to be_in(["/", "/lists"])
end

Then(/^I should not see "([^"]*)"$/) do |arg1|
  expect(page).not_to have_content(arg1)
end

When(/^I am on list "([^"]*)" detail page$/) do |arg1|
  visit "/lists/#{arg1}"
end

Then(/^there should be "([^"]*)" lists in the database$/) do |num|
  expect(List.find_by_sql('select * from lists').count).to be(num.to_i)
end

Then(/^there should be "([^"]*)" tasks in the database$/) do |num|
  expect(Task.find_by_sql('select * from tasks').count).to be(num.to_i)
end

When(/^I complete "([^"]*)"$/) do |name|
  lists_table = page.find("#tasks_table")
  tr = lists_table.find('tr', text: name)
  tr.click_link("Complete")
end

When(/^I complete important "([^"]*)"$/) do |name|
  lists_table = page.find("#most_important")
  tr = lists_table.find('tr', text: name)
  tr.click_link("Complete")
end

When(/^checking pages that should not exist$/) do
  # step placeholde nothing happens here
end

Then(/^I should not be able to get on list "([^"]*)" task "([^"]*)" edit page$/) do |list_id, task_id|
  expect { visit("/lists/#{list_id}/tasks/#{task_id}/edit") }.to raise_exception(ActionController::RoutingError)
  expect { visit("/tasks/#{task_id}/edit") }.to raise_exception(ActionController::RoutingError)
end

Then(/^I should not be able to get on list "([^"]*)" task "([^"]*)" detail page$/) do |list_id, task_id|
  expect { visit("/lists/#{list_id}/tasks/#{task_id}") }.to raise_exception(ActionController::RoutingError)
  expect { visit("/tasks/#{task_id}") }.to raise_exception(ActionController::RoutingError)
end

Then(/^I should not be able to get on list "([^"]*)" task "([^"]*)" update page$/) do |list_id, task_id|
  expect { put("/lists/#{list_id}/tasks/#{task_id}") }.to raise_exception(ActionController::RoutingError)
  expect { put("/tasks/#{task_id}") }.to raise_exception(ActionController::RoutingError)
end

When(/^I click "([^"]*)"$/) do |name|
  click_link(name)
end

Then(/^I should see "([^"]*)" inside "([^"]*)" input$/) do |value, el|
  expect(find_field(el).value).to eq(value)
end

Then(/^there should be "([^"]*)" tasks for list "([^"]*)" in the database$/) do |num, list_id|
  expect(Task.find_by_sql("select * from tasks where list_id = #{list_id}").count).to equal(num.to_i)
end

Then(/^I should be on new list "([^"]*)" task page$/) do |arg1|
  expect(page).to have_content('New Task')
  expect(page.current_path =~ /\/lists\/#{arg1}\/tasks/).to be(0)
end

When(/^I remove "([^"]*)"$/) do |arg1|
  first("#tasks_table").find('tr', text: arg1).click_link('Remove')
end

Then(/^I should see "([^"]*)" or "([^"]*)"$/) do |arg1, arg2|
  expect(page.text.include?(arg1) || page.text.include?(arg2)).to be(true)
end