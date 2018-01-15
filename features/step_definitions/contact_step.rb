After do |scenario|
  #save_and_open_page if scenario.failed?
end

When /^I fill in the contact form$/ do
  fill_in :content, with: 'This is a test from cucumber'
  fill_in :user_email, with: 'visiter@lycos.fr'
  click_button 'Send my message !'
end

Then /^An email should be send to the admin$/ do
  expect(page).to have_text 'French lessons'
  expect(page).to have_text 'Your message was sent !'
end
