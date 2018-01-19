
When /^I request a new lesson$/ do
  visit lessons_path
  click_link 'New lesson request'
  fill_in 'lesson[date]', with: '2050-01-01'
  fill_in 'lesson[time]', with: '17:30:00'
  choose 'robert@cucumber.com'
  click_button 'Request lesson'
end

When /^I request a lesson without providing a date and time$/ do
  visit lessons_path
  click_link 'New lesson request'
  choose 'robert@cucumber.com'
  click_button 'Request lesson'
end
