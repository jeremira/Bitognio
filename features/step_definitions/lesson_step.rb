
When /^I request a new lesson$/ do
  visit lessons_path
  click_link 'New lesson request'
  fill_in :datetime, with: '2050-01-01 14:30:00'
  choose :robert_teacher
  click_button 'Request lesson'
end
