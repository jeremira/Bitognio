When /^I request a new lesson$/ do
  visit lessons_path
  click_link 'New lesson request'
  choose 'robert@cu...'
  fill_in 'lesson[date]', with: '2050-01-01'
  fill_in 'lesson[time]', with: '17:30:00'
  click_button 'Request lesson'
end

When /^Tomoko pay a lesson to Robert$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  robert = User.find_by_email('robert@cucumber.com')
  lesson =tomoko.student_lessons.build(teacher_id: robert.id, date: "2099-01-17", time: "14:30:00", confirmed: true)
  expect{lesson.save}.to change(Lesson, :count).by 1
  visit lessons_path
  click_link 'Pay my lesson'
end

When /^Tomoko requested a new lesson$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  robert = User.find_by_email('robert@cucumber.com')
  lesson =tomoko.student_lessons.build(teacher_id: robert.id, date: "2099-01-17", time: "14:30:00")
  expect{lesson.save}.to change(Lesson, :count).by 1
end

When /^Tomoko pay the lesson$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  lesson =tomoko.student_lessons.first
  lesson.payed = true
  lesson.save
end

When /^I request a lesson without providing a date and time$/ do
  visit lessons_path
  click_link 'New lesson request'
  choose 'robert@cu...'
  click_button 'Request lesson'
end

When /^Robert confirm the lesson$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  lesson = tomoko.student_lessons.first
  lesson.confirmed = true
  lesson.save
  expect(Lesson.where(confirmed: true).count).to eq 1
  visit lessons_path
end

When /^I have some funds$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  tomoko.account.balance = 99123
  tomoko.account.save
  expect(tomoko.account.balance).to eq 99123
end
