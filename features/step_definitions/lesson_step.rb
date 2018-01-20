
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

When /^Robert confirm the lesson$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  lesson = tomoko.student_lessons.first
  lesson.confirmed = true
  lesson.save
  expect(Lesson.where(confirmed: true).count).to eq 1
end

When /^I have some funds$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  tomoko.account.balance = 99123
  tomoko.account.save
  expect(tomoko.account.balance).to eq 99123
end
