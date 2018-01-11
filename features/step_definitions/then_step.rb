After do |scenario|
  #save_and_open_page if scenario.failed?
end

Then /^I should see '(.+)'$/ do |stuff|
  regex = Regexp.new(stuff, 'i')
  expect(page).to have_text regex
end
