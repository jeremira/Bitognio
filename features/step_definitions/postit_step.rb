
When /^I fill-in postit form and submit it$/ do
  expect(page).to have_content 'Make a postit'
  fill_in 'postit[body]', with: 'Hi, looking for a nice teacher'
  fill_in 'postit[planning]', with: 'Monday, 14-16'
  click_button 'Find teachers !'
end

Then /^I thing$/ do

end
