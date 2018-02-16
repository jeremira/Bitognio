

Given /^Teacher Robert exist$/ do
  visit root_path
  click_link 'Sign up', match: :first
  fill_in :user_email, with: 'robert@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first
  click_link 'My account', match: :first
  click_link 'Become a teacher'
  click_link 'Ok, got it !'
  fill_in 'career[last_name]', with: 'Baratheon'
  fill_in 'career[first_name]', with: 'Robert'
  fill_in 'career[dob]', with: '01-01-1975'
  fill_in 'career[adress]', with: 'rue du singe'
  fill_in 'career[city]', with: 'Winterfell'
  fill_in 'career[zipcode]', with: '75014'
  fill_in 'career[iban]', with: 'FR89370400440532013000'
  click_button 'Register as a teacher'
  robert = User.where(email: 'robert@cucumber.com' ).first
  expect(User.where(is_a_teacher: true).count).to eq 1
  expect(robert.career.connect_account_id).to match /^acct_/
  click_link 'Log out'
end

Given /^Student Tomoko exist$/ do
  visit root_path
  click_link 'Sign up', match: :first
  fill_in :user_email, with: 'tomoko@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first
  click_link 'Log out'
end

Given /^(.+) is log in$/ do |user|
  email = "#{user.downcase}@cucumber.com"
  visit root_path
  click_link 'Log in', match: :first
  fill_in :user_email, with: email
  fill_in :user_password, with: 'password1234'
  click_button 'Log in'
end

Given /^I am logged out$/ do
  visit root_path
  click_link 'Log out', match: :first
end

Given /^I fill in and submit signup form with '(.+)' and '(.+)'$/ do |email, password|
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password
  click_button 'Sign up'
end

Given /^I fill in and submit log in form with '(.+)' and '(.+)'$/ do |email, password|
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Log in'
end

Then /^I should be logged in$/ do
  visit root_path
  expect(page).to have_link 'Lessons'
  expect(page).to have_link 'Payments'
  expect(page).to have_link 'My account'
  expect(page).to have_link 'Log out'
end

Then /^I should be logged out$/ do
  visit root_path
  expect(page).to have_link 'Informations'
  expect(page).to have_link 'Contact'
  expect(page).to have_link 'Log in'
  expect(page).to have_link 'Sign up'
end
