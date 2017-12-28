After do |scenario|
  #save_and_open_page if scenario.failed?
end

Then /^I should be logged-in$/ do
  visit root_path
  expect(page).to have_link 'Lessons'
  expect(page).to have_link 'Payments'
  expect(page).to have_link 'My account'
  expect(page).to have_link 'Log out'
end

Then /^I should be logged-out$/ do
  visit root_path
  expect(page).to have_link 'Informations'
  expect(page).to have_link 'Contact'
  expect(page).to have_link 'Log in'
  expect(page).to have_link 'Signup'
end

Then /^I should see '(.+)'$/ do |stuff|
  expect(page).to have_text(stuff)
end
