When /^I fill in and submit teacher information form$/ do
  expect(page).to have_text 'Teacher information'
  fill_in :user_email, with: 'robert@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Sign up', match: :first

  choose 'robert@cu...'
  fill_in 'lesson[date]', with: '2050-01-01'
  fill_in 'lesson[time]', with: '17:30:00'
  click_button 'Request lesson'
end
