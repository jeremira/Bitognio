When /^I fill in and submit teacher information form$/ do
  fill_in 'career[last_name]', with: 'Baratheon'
  fill_in 'career[first_name]', with: 'Robert'
  fill_in 'career[dob]', with: '01-01-1975'
  fill_in 'career[adress]', with: 'rue du singe'
  fill_in 'career[city]', with: 'Winterfell'
  fill_in 'career[zipcode]', with: '75014'
  fill_in 'career[iban]', with: 'FR89370400440532013000'
  click_button 'Register as a teacher'
end
