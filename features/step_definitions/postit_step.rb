
When /^I fill-in postit form and submit it$/ do
  expect(page).to have_content 'Make a postit'
  fill_in 'postit[body]', with: 'Hi, looking for a nice teacher'
  fill_in 'postit[planning]', with: 'Monday, 14-16'
  click_button 'Find teachers !'
end

When /^Tomoko has an open postit$/ do
  tomoko = User.find_by_email('tomoko@cucumber.com')
  postit = tomoko.postits.build(body: 'Hi, there', planning: 'monday')
  postit.save
end

When /^Robert declared himself as available$/ do
  robert = User.find_by_email('robert@cucumber.com')
  postit = Postit.first
  memo = postit.memos.build(body: 'Oulala')
  memo.teacher_id = robert.id
  memo.save
end

When /^I fill-in the date and time$/ do
  fill_in 'lesson[date]', with: '2050-02-02'
  fill_in 'lesson[time]', with: '18:15:00'
end
