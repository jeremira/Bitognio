Given /^I am on the home page$/ do
  visit root_path
end

Given /^I click on (.+) '(.+)'$/ do |cliker, name|
  if cliker == 'button'
    click_button name, match: :first
  elsif cliker == 'link'
    click_link name, match: :first
  else
    fail "#{cliker} is not a valid cliker"
  end
end
