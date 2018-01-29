Given /^I am a registered student$/ do
  visit root_path
  click_link 'Sign up', match: :first
  fill_in :user_email, with: 'tomoko@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first
  click_link 'Log out'
end

Given /^Tomoko register and log in$/ do
  visit root_path
  click_link 'Sign up', match: :first
  fill_in :user_email, with: 'tomoko@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first
end

Given /^Robert register and log in$/ do
  visit root_path
  click_link 'Sign up', match: :first
  fill_in :user_email, with: 'robert@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first
end

Given /^Tomoko is logged in$/ do
  visit root_path
  click_link 'Log in', match: :first
  fill_in :user_email, with: 'tomoko@cucumber.com'
  fill_in :user_password, with: 'password1234'
  click_button 'Log in'
end

Given /^Teacher Robert exist$/ do
  visit root_path
  click_link 'Sign up', match: :first
  fill_in :user_email, with: 'robert@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first
  robert = User.where(email: 'robert@cucumber.com' ).first
  robert.is_a_teacher = true
  robert.save
  expect(User.where(is_a_teacher: true).count).to eq 1
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
